Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD35477E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218187; cv=pass; b=hEEpfA20PrUkPnrwlTOA9ehPmfhA9LZCC+75oVpFkY0cIBZOBUIHvHPjkE2NlICnQwzQiWOUwJiYA1tTYdZiwWWJTFJvd0gktuE+ykBmR0GvDKALvm1ST6yXtkmDl2l4VSiwkoVfZ75JRvpX/YrKRlS3T9gIhAY6JUQ3I/H3wWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218187; c=relaxed/simple;
	bh=GB1lyO/2CR7gHcqPwaBv+RJxLg5xr0y84IaUck4pUvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feLi1LBhMtJjvzmmY0fAUDMDj80DJsOdQPsMAo9jKZDqIXLbOoYj5GVUne8CFCiylZwK27tuLWUqHn1jzDaytPxVY8M0P1iYMImZjx6P18dNfBHgbX5vZu0FJ3Le7fGbs4FrGzhoCi72o8BCLuP/7zNZcsqFGMdOVGOlPcdrhUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM9qIhz9; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM9qIhz9"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfce3a195so3859159f8f.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 18:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776218184; cv=none;
        d=google.com; s=arc-20240605;
        b=JCvxXQipth4LRozNxZ4M7w0O00cW7AqobFfyU3305/FW1CVMlToISZP8gzB5Ssm2ny
         gkw7+oDjNUbwmf8GcXustsCP9sjipzch39J52VuZmI+JT+H+ubQ467qMNX0xfO9jjIcW
         i8Y+rb7jXd6i+ZxjaRKxPlqtVNWUBIn9CZTa6KxZmviDT4enS8kH0wB6lDsR3kWVVl0x
         dUJOE2foZSxOltuqQstSEQENw5Ctr5U6pRgAkGyEKa6RezKTZ+XLDyvVrxC+s2rgYt5T
         UK3xBdKV8xjTZWr1MqbQQf67hOlreogrkAVAvF7y81gAFUb9myqN8gwMQvcpPPHEaN9i
         srcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Kf9JPLXPTMyPgusFLEmoAvtAE1xRrdBSXPu8WhnMrM=;
        fh=5Vju2ZEWkNjPy9GAdaq94hGpj4sbs1ihFanhYGJjwmU=;
        b=iPfWlmi5F4Qejb+WicNH/+v/wtArNtmXl6R6cuAI7PRZv2TAZkeDU0bfYfjer8IPB+
         Ey9tYYApUo+Yz9gxCXNoxDQ2QxzH4VLCH4bg12lkLY5sJeGw43qA+5Bb34foHAhPfqNh
         ZbY2UGLX6fpY8iMniHoaC6P32/bJ/NU/aM5HAMagyV60+5B2FwZWt8plHZBQ3h6yWOxX
         Y4EEmio63hSIWKglrDhPjGQ3X7BTw944X/8xzzZMP9WekOjxTj7vMizDDpitQUmCmWDg
         +/uQvjJV2h7V3FHFCSUyo/75vkQ6fF0TgNXywilq9fASp8v+X699S+qf1I/MijStAcWV
         +o2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776218184; x=1776822984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kf9JPLXPTMyPgusFLEmoAvtAE1xRrdBSXPu8WhnMrM=;
        b=FM9qIhz9yYuE7ysY3y33EEHiNm/NuqDsgGi2z8AxFoOhNWAmdDbSKxMCcCG9l+OtlO
         kn6MFr8ton9YN0W8rDH79pfs5GMrWk4Lw7YwJOxDM9RzQgD4V0hPow6zjYl0Hq77d/Tp
         DkJ0qFSf6uJ2x89Ym51rmJct98LgoRgIY6eWn8DC3KLtsDSozQnivLQLYKf4CtnekH8z
         YVO1dwpWF1VQ2lIdnQq/Dupn1Eoe5RX+7vMSRpiyWl540msdsli7Kg2kGd2jKpbPaxkF
         tVDcmgySDkawDURrXHaVvxfJRc5GxZEiX9Kvu/rPn8SvAfoge2ICM/hwuIeWy0yfSlhG
         fnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776218184; x=1776822984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Kf9JPLXPTMyPgusFLEmoAvtAE1xRrdBSXPu8WhnMrM=;
        b=sX4Ib5x7Diy47M+QLs1ovLvtWc3D/RPFxDsaHNU2lSVLZ/h3LDMt1v1Niq3M5JQWu8
         RA5eYXo6v+wbIccOIpvk3CPMxXGhusL7D/lPZA73esNZlUSYREfCJU6KiYDnZQq0eY6A
         UeSpiHS4BuP4LLUTyGsL3J81mMhjnWVaAIUonLFs8K1lVRrxS2QoTtcf/wTKY1wx3rAu
         9WYhP7hzxP27VSLHrnBrVloHW3xqK0Kej0swrLr+VWWBc276N2JrIf6i126LPY6OFufD
         gNAMrOvistgxEoMu9gnpRar4MT3dqtsrMyvAD3zgtThsGTr08/uWP4qPkLjD8wl4oCUM
         F4gQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MFz1PCEUeax1AoiF75+e20hpBFchG85CmXMvdolZ9aGwpPqFrG7DhJxMHgqLy1lSAZAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ouWpnsjBjww8ADJZQM2y7Xb2zNbRhgcJA7Q44D0QjGIa1b3k
	PpZhuSOaHjm0N6siXfVSlSroTVlJUGxq8e++mNUYaq1NP3dqHozGmop/uXGrm2G2Wu/srGUoRCs
	vbUuMVCWvrg9TId7W8qMsx57ZMlCzP5zGMQ==
X-Gm-Gg: AeBDies7Q0Z8hik5YxMqefv0UxnWBjrXn0/xMw8LeaFYNlVU9kOf3aqq7d60nxJJLEk
	1MZMebvIra2pZc6DDSQ0eeWcBxWJE/ixDhTBjHzFU+mr0v92jzprEK5bXkCvZGHOdz9LIuKtQtH
	JJ2JGSrHMd2EPHfQMP5Vz7xM/cK3JP6zJHpTUN9/p+/b9Q1fC8wv9OV89WBw1H2SJ48bFAWctfm
	7G4e1dZlIxXc/I5Qj+AYbUTO/K96fVhZCfqL9jPyqmKp76zJ+svFhdyh4zVPbva4Ev4i9NP9WPU
	i6NVFre03uhiO9wfXhTJYqL8tL0GopG5bvAJP+TIH7JjztBj/7p8EHrDfR1uGlELhv1O6g0so2f
	4m38DnAhiaRXOP2LR7yu59IeqbTMGtR7hz1k0
X-Received: by 2002:a05:6000:420c:b0:43e:a638:2507 with SMTP id
 ffacd0b85a97d-43ea63825e2mr7037711f8f.8.1776218184131; Tue, 14 Apr 2026
 18:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414195019.684531-1-alan.maguire@oracle.com> <20260414195019.684531-4-alan.maguire@oracle.com>
In-Reply-To: <20260414195019.684531-4-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 18:56:12 -0700
X-Gm-Features: AQROBzDIw3W7DIWK1XEHHxuxrKVzau6OQ8DxRsQszhNry-2PtjkmSjezGTSuXno
Message-ID: <CAADnVQKGjLX=PZYtJJ7Lb1S-OOoCBu4x32V=XxarNkAKjQt-HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] libbpf: Add feature for kernel extended
 vlen/kind support
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:50=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> Add feature check for kernel extended vlen/kind support, and reject
> BTF that uses extended vlens/kinds if the kernel does not support
> it.  There is no reasonable path to generally sanitize such BTF.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/features.c        | 39 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          | 17 +++++++++++++-
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  3 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0c..4a75d6717bbb 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -615,6 +615,42 @@ static int probe_kern_btf_layout(int token_fd)
>                                                  (char *)layout, token_fd=
));
>  }
>
> +static int probe_kern_btf_vlen_kind_extended(int token_fd)
> +{
> +       struct btf *btf;
> +       int ret =3D 0;
> +       __s32 id;
> +       int err;
> +
> +       btf =3D btf__load_vmlinux_btf();
> +       err =3D libbpf_get_error(btf);
> +       if (err)
> +               return err;
> +       id =3D btf__find_by_name_kind(btf, "btf_max", BTF_KIND_ENUM);
> +       if (id > 0) {
> +               const struct btf_type *t;
> +               const struct btf_enum *e;
> +               const char *name;
> +               __u32 i, vlen;
> +
> +               t =3D btf__type_by_id(btf, id);
> +               if (t) {

Too much claude.
Please reduce the indent.
Easy shrink by 2 tabs.
