Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0A43498B
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895367; cv=pass; b=GR5VdCQtga1UjKJEz6Yypon9IT7Sa81Gdt84ylLUzM1O0dlemjNrTciP9pNO2lkIyHSHsauWy5NptP5ZNqocwhiIRwjl2eEIe6IBd3zmISLpne5ogptFki6TTFEFY19W1ZMsYZODZ6xKTaxhIJR8WhfMaiCTkYhYsSLPz/fyoDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895367; c=relaxed/simple;
	bh=ekxrhGBDmqQ2a99GHwuaYYcGX/EuoM7tTpZBWWzPM9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxpX45ibSumn5B7/cNZtoBd/CFkUNp47nC/I+lufzATabD5QcIkXPiE1AyCuhkhAQnv8sdD0BdVzfu8O3ZY0eyb9mTJfJPn4qcuOSy2l2F7Ng+DWSjL0zcKXU3GkRinHH08AvJ7yWpJcgv1he39jBkALWCGBGr/pCUtMJ8KZ0TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=yYNZLYkp; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="yYNZLYkp"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8e6bdso916756d50.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 12:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788895360; cv=none;
        d=google.com; s=arc-20260327;
        b=p+jeIdl4ChKkA76830V6e2lNxKJhnpAtlHxAzlQtq+HbXsNyyy8b0blxcqrld6mnou
         d8LiWePmEQywmetUu6vApAl9FWCI866gPjFxSBpVi7PyBtjZ8tWlu1kcyHDa+Nupiec7
         wTzplEq43dQziJLhbw1sf7BNylddawkD1185H0F+/BQN9dUh0pxG+DO2pzD1ybjF6Ea9
         B03viLWh3w8J3vBCmsjXXluBAHFD51H/L3HBoOPt+0bmt530lO0z353IB3xAoKboDJM1
         awK0dU3TGRSfiUz4hxbpSSXHk6FSYAAXcB3DAZjakRgYMOG+XvGJZW99Wz6urozIY7t/
         XVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9cK0fKrDwYDxi6yXvcwrmh6awv2gyzlFkyEcXA7bkc=;
        fh=5bG9Ph3wKY1cq0b9UgO3oml+l2PwNGRHDr56ATb400I=;
        b=XlowzwgztPtc+zQaa89ymQUQ82/9gvOLli894DTGt+j3PxOFz7h+OSZlihIJVpSJuV
         arzb5MQpY7HfubQrp5oVxhtXM7K35EqRsCYu/Lw2+tZ/FoahnKVXr40L+PimbXaP1bs0
         f6PzXw8VBcy6fQAJs4zp8hfPC0fKrXbnmH4SkHyH5nk1t1pnYsVzWkyTsEYEvFf7Yt/d
         SAHfGPjVj5AGjmPm8H95CfUdoz0dF+ok3DJB19W4/BZfFMoRCc0d4TafGR1eP9Xttbtu
         CFtqtdmTUzqlwqQmsZmpZpk9H8Fgc81YkQu0TFcabi7S3XGdmf3RS5/prsVWOZDTjmdJ
         q8gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788895360; x=1789500160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y9cK0fKrDwYDxi6yXvcwrmh6awv2gyzlFkyEcXA7bkc=;
        b=yYNZLYkpxVaXxHqyY4Ya4zP2eU1k/y9thJKNQIoKVFt1Ascrrv4AU0F9ayJiuQZ6SG
         Ijr/Sa7ovlY4QXosswLzUvPxhMdOobOOPagayNOcui/ePlXpEyXM4iOHEw4WdtRPrC3B
         ZVd3A+nHcEGwU0Fz5zy2IaVHVzOD51+RH3u5Ev+SjLiwsNcZD0Z3/fjRVMZxxgvv9RiW
         63VQnX/Elpx30SYGEsAYaR0PNQ/MAyJT780A3ODzhPfAuc6u18EmMmmqGvIbyJkC4sn2
         00Bc/vM6ixM7USda7bLB/4zRRb10QbGtGu7qGY3PM1wS5sWYdRtdjvnDj7NjvLfnHJfT
         vJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895360; x=1789500160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9cK0fKrDwYDxi6yXvcwrmh6awv2gyzlFkyEcXA7bkc=;
        b=CiAbZOibFxlOoqFA6TQVveeQ3r46fR4GTTad+9L+3vQ02/cWZonixxTFbV6mf7Hc8M
         BcH5G5+WMLDjoJg+V6YJnvsKUaUVzIhIdxDjyp16WMY0uZlHjIaPougY7ixEiI0MKo5d
         i8taVgGs118swYgMghIck7llzrxBZayBtqhmSfzvU9QajvJAhLJxzzS7AsCf8EbPyDvR
         nbnjRQIRiJQ/GCianA6iBHwhzu1J1eNic+UezbWZoNK66YomCmZxXYXYfbCmQ+COEkcc
         VgMiHmXF2ESKBQBdDacn5cXhryEqGxBQdGgXvhNITeLixKZBRkgarg7G3VnSx9xvbAn8
         wyOg==
X-Gm-Message-State: AFuF++n4UDsQLOmS8sJY1I/+SdWHqxXHwuGRsx08ZPM1aUlWwApP32jp
	KSyJgaxjEjbn0m2mSGbDZ1VwktcxS6CjfWo/VnCu+uLRQakSOmvUQYEpRzeVlucuWlhnATUIWyV
	DHc7gKw7i9AR04+6Ahklspi/O42aPSzNAJUFvhiUTDA==
X-Gm-Gg: AYBFou0GGZAPCd5QSsGPQb7vzAMWFmL4XPvdevzLGdfI/CTPSGGyjTi6/0TfyPzpsGy
	gDNCZvg8kfqi2AYDg+9pUnCnQQ/OFmTTFA3y4EuSGTZ9dAq/vGr3Y1dYYgJy0iAaVYgx7ASYPDG
	b/WeTUPkoPUUxZiR/lYbQspQVo1dYIpZLWMSKu4koWb4LeggUHF7i0Nb3yMLw7ATtjoUmRw9X1K
	y8dhE5C/k3lavamWH0OCze01g7FPQFUQH1q0+U0UBGWu6Lhyd9VhmdVtxp1wquxDDf7OQheWnY7
	/0dM56rcI1Co0CnLuPTUfos0OTM8p6dW55e2Be4pBECI
X-Received: by 2002:a05:690c:6610:b0:81e:d001:e0ca with SMTP id
 00721157ae682-87c0cb08accmr24554567b3.17.1788895359812; Tue, 08 Sep 2026
 12:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830093514.4105972-1-memxor@gmail.com> <20260830093514.4105972-6-memxor@gmail.com>
In-Reply-To: <20260830093514.4105972-6-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 15:22:28 -0400
X-Gm-Features: AcwNN1X3dpCgA0K_vsGahpw6WDiGIUKpqBQpj0_bSKOk8gIPII4acyw3snx4w6c
Message-ID: <CABFh=a6dfV_NqvBodU6H2XeOPHzjZTZYEW=yF+-t6guMwyDoKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] bpftool: Read program streams through
 file descriptors
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Use bpf_prog_stream_open() in its default blocking mode when following a
> program stream. This lets bpftool wait for later output instead of exitin=
g
> as soon as it drains the currently buffered bytes. Flush each chunk as it
> arrives so redirected output is not held in stdio buffers while the next
> read blocks.
>
> Fall back to BPF_PROG_STREAM_READ_BY_FD when the open command returns
> EINVAL. The bpf() syscall uses EINVAL for unknown commands, so this keeps=
 a
> new bpftool compatible with kernels that provide program streams but
> predate their file descriptor interface.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Bot's caveat aside:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Out of all options for graceful exit imo it makes sense to modify the signa=
l
handler since we don't have a way of refcounting the program till bpftool
is the only entity with a reference.

>  tools/bpf/bpftool/prog.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a9..6b43cb43b27e 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1125,14 +1125,27 @@ prog_tracelog_stream(int prog_fd, enum prog_trace=
log_mode mode)
>         FILE *file =3D mode =3D=3D TRACE_STDOUT ? stdout : stderr;
>         int stream_id =3D mode =3D=3D TRACE_STDOUT ? 1 : 2;
>         char buf[512];
> -       int ret;
> -
> -       ret =3D 0;
> -       do {
> -               ret =3D bpf_prog_stream_read(prog_fd, stream_id, buf, siz=
eof(buf), NULL);
> -               if (ret > 0)
> -                       fwrite(buf, sizeof(buf[0]), ret, file);
> -       } while (ret > 0);
> +       int fd, ret;
> +
> +       fd =3D bpf_prog_stream_open(prog_fd, stream_id, NULL);
> +       if (fd =3D=3D -EINVAL) {
> +               do {
> +                       ret =3D bpf_prog_stream_read(prog_fd, stream_id, =
buf, sizeof(buf), NULL);
> +                       if (ret > 0)
> +                               fwrite(buf, sizeof(buf[0]), ret, file);
> +               } while (ret > 0);
> +       } else {
> +               if (fd < 0)
> +                       return -1;
> +               do {
> +                       ret =3D read(fd, buf, sizeof(buf));
> +                       if (ret > 0) {
> +                               fwrite(buf, sizeof(buf[0]), ret, file);
> +                               fflush(file);
> +                       }
> +               } while (ret > 0);
> +               close(fd);
> +       }
>
>         fflush(file);
>         return ret ? -1 : 0;
> --
> 2.53.0
>
