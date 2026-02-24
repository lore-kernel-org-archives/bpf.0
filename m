Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F027E0E4
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901930; cv=pass; b=JTHvea3pbXyHIK9pEHqXgPyD0iixlU4EwPxQXEaM6B3A96q2+KtWHn6w8oPSt+1cXtMCrL75wAr0nkFOqXoS+/KHoaNtDzpzZcwYlcHds/DLT2PodP7yJgJWVzuiMStpjcTFrJyxeEh3AWhYPlSEz98KNOvUCe8Qpzf3T2xEW3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901930; c=relaxed/simple;
	bh=tOd+OOw38MI45+QlWtqhkOuDIRdBXvPQzcU7osEsBRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIpqIge5Z+HZQOB4qCEjl2EZS9Et9HQZX7E5UU3P1K53WMvCzqXhvlp1am/FQ9isU7MwTchOKRiFT2CyWvtMdRF0zTRiucH0UoHo8Iomj36wmJQYWRFQjxzczphRV8fseNJf6SPMoUSUnA+aug0k5TozS07cUxjOPOVXPVFUW3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai3aRsom; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai3aRsom"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362507f0bcso3516175f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:58:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771901927; cv=none;
        d=google.com; s=arc-20240605;
        b=aGBgY6QruV85rX8RyQfSLYsy6c3qeRoqaQuMRBbMybvdcsNjYU2oAeG73RAi6sZAE9
         T9+U9Q6XzNfxBB+NKLNfiEjEpw4vrCJ8ZR2RUMl01YxcR/l7IUR0tS2a8gNNPu3ejzGk
         wb4y05eipV0v+lpTXH17gz/vJK+y8MXESgewsxatEhPr85HaGY73qN6MAEfoPiGcGZf+
         FgpVlk2uFvHFBCl5rrY/tdL0DbbadLFwUPlbFmtFFF/sykxD+mN5NAiY2WNkXwxbncnj
         c9hJpKNn5uM3BBwKmyq2u/Lil0SA3rx8U9XWMzp8HZoQuLhEBm5UHy4jzbdp5rHZuoBw
         BVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tOd+OOw38MI45+QlWtqhkOuDIRdBXvPQzcU7osEsBRc=;
        fh=cYWxAO4hEA81svD5X/DiiNB7a/xE2yZ32mprOvFjECI=;
        b=E4k9VG4ztKdmamYfoX6YvEKq3/QSNgue+wnRDz/ud+h8k0p8NmkNAQZEnxVwo+LsoY
         BlNVFtTH0AH6r58MKYZrrcZEaat2wHfdAH2k72leExpe2D04+u62OWLBQhE0I9lFWvMP
         7Zi8lIYJwLj0DZ2Bwj+zTtgLQTNKLH7BaL0al+JINd+41BrgAr+ksxtIamX7/KHACG+R
         +7Vkef/EC+npKyUETv+I7R+XLH0LN3Cy0vCHnaZ9KjgK3NkjwDNQcqeCvHgkCk2LFM4P
         R5FU6isZKRGrW281t9bppJNG2c7O+2G6Aw9do6aRpoIFobxHFHlL87oV1nwJ9TSBs46i
         ywTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771901927; x=1772506727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOd+OOw38MI45+QlWtqhkOuDIRdBXvPQzcU7osEsBRc=;
        b=ai3aRsomVi/83OIy7zOebEaC2zsQhgeUk6evt7ioGC14rGt3yKYoTzS6kmTU5v0GiI
         36zQ3VxPX2VpIU+0B4fISS9IiMOasjORzL7jvlK+G6Q/Fj+1BlMmSHi5KAPVnwU6gD0j
         ovk6oGUXA4aTsbLDQzY4FkHlmYIc07dggpcNim9anAUluQPeRdP5xfpewb8jGfx618nY
         VRFNBgzJVBmiuBXntQvZm+iv6jWdbxXjDhygLbci7DDCmf81MNs+o2ErT/KJxz66t6lF
         YF9ZooDmNOkgpjuMZpAvAPN0q9KhCZBWmxTRkGP0MNc1WhOI1PuQDqQu5IVSQtq8/Lj4
         0E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771901927; x=1772506727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOd+OOw38MI45+QlWtqhkOuDIRdBXvPQzcU7osEsBRc=;
        b=eZj14D8UPJHTH0iLoZEBF1IPbUeP3vZnIAo5K09fI0W/UrZN74vpn7iDeBcIBR294a
         MAmLxELqUKEK+D3yGYbF6VYEP6wocVL/qnSL/GY+LFGlnxJKd/5p9xAd/EP9K+bME9VT
         JpPE0TYp55VcNHFiW9JBkTkTOhcEalh4k4xqbV4k2N+vfqCfpWb35V6BYSU5yzKXwkWt
         bLSz2QnJhbLm0YgL6an6QLXSRuPpSxxukITig9gBRyRQ5m6f1VZ8IbxBAGHVBRvQrYLp
         3Ue1lF8DglWan72Sxsi0hr49bnSpOnYBlrf3+pmevMHUyY0XVxDNy14HMyAT2RxqsrwG
         xbNw==
X-Gm-Message-State: AOJu0YyumH4tLZnueO76ItIdPrEZ7IB+q2r8MwMXTSXc3yMLofH9H2D3
	dVi2P3zQBKDZ6o07d905h9WMN+Fc2uSKGYSczwH6H4nJo3imMQ2qOCXUmzRhiN1zOQhvfyXFj2N
	TlIzBRmum0z+5NNr41wpoCCP51qLYbJM=
X-Gm-Gg: ATEYQzxVjo3+7LVpO4el1VpvdsHhf83IA86wU+wWMA+2YGTrXEQ8ReA+uKCAdf8BIwg
	FCCnc58Hb3wFTWlRQB6eme500atvVJXA+mwyrp3rls3ZKQvGutFl88SkLe75vg+o/GEqRYxPg9R
	hFynb0yN52zWt4vHpkOYnv5QDQYNY9FrOTGA18w9sGn8gdeSwF+yqSuRhs3tQmZdOD8xwSksb26
	QslK+SenJOYueHcd/rXLZdyrwEVIwD2mYZDaohfXO1Gz8rsw102qjVcLYJjpzgPbTysBTjqu67x
	MBD3Pp3UcGayvR43S7CC9PDiuCq6XfAOx0c0f6p1yQ4XX4mlufhOKtQx9ojn/rcwpKIQOpx49CD
	iFcXjcc/aQQMLgplLYMhIYv0x0w==
X-Received: by 2002:a05:6000:4211:b0:437:6b6e:d108 with SMTP id
 ffacd0b85a97d-439626c7da4mr26621628f8f.8.1771901927057; Mon, 23 Feb 2026
 18:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770736390.git.vmalik@redhat.com> <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
 <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com> <CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com>
 <582944ed-ddd6-4843-ba36-b4aed03c5b2f@redhat.com> <CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com>
 <d2706604-1674-49fd-a150-7ace8839657f@redhat.com> <CAADnVQLT7cGgExtaqusyk+XwrD=-x15kL0veJB5YPewjPo=PUg@mail.gmail.com>
 <fa67d3db-273f-4e4e-90a2-ba805f484bd1@redhat.com> <0675cf92-1833-4f1a-bd8e-53de5cc1ed7e@redhat.com>
In-Reply-To: <0675cf92-1833-4f1a-bd8e-53de5cc1ed7e@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 18:58:36 -0800
X-Gm-Features: AaiRm520WPQ-BGS-IIRDhggH3rpFmXh7moQAsy6sy7i3u1bmLkVhWUd7b6ey8S0
Message-ID: <CAADnVQ+BQZd4C8Mc4U1AnpQNPhouwjO=w89ORgF05AsoAH0RHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Separate tests that need error injection
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jordan Rome <linux@jordanrome.com>, 
	Qais Yousef <qyousef@layalina.io>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:52=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
>
> Looking into this more, I assume that the premise here is that injecting
> errors into syscalls is not sufficient to implement a rootkit, more
> mechanisms are necessary for that (even [1] uses bpf_probe_write_user
> which is by default enabled on any kernel). On top of that, there are
> tons of other ways to compromise a system using eBPF so enabling error
> injection doesn't change much in that direction.
>
> With that, I'm ok with enabling fmod_ret for syscalls even with
> CONFIG_ERROR_INJECTION=3Dn, I'll send a patch.

Now we're on the same page. Thanks
