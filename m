Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125C33B6D5
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333494; cv=pass; b=Gz/jqhjn0kf9sKRx2ejYh2kV141AH5HFHMil0UFDy/St1myKh91sLDYsBqIcUhBYvAYUE8KmIBNb8YBES9kyDL6oDetGsXnOyZr7dyFKC/f5q0qOMBUI5Y5KNVsfxMGiI6b8to33Ptxxd764dXuuUbFraqDU1sC5WM/jcr0HoKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333494; c=relaxed/simple;
	bh=3DMdSbOnTDuQkq267j9yDrVRURkKzUdqV8Rm0kiBb5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxgKfac34ai3M68O2OjHT1itn9jSAkeT8q0tNgUXMCm/maYsX8mDu9ztDtJE82cY2zHpw9j2Qmd/YkaWdc45p49Y1QErq+5zedlSj0euunyGkeNm/0FInVHKqn8dnB32o/8hy3fxI2mO82soBSaI0ZmtkY9UIMXy0AjmrUbkAoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsFEC+5x; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsFEC+5x"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43590777e22so49844f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 15:18:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770333492; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3tmaPm6DT208UjRQjc5Pn3NtYZeU/75x0mCvxA08qomunE6abAkBxkbaZxgkraAK0
         7u92hCXzVQsXNfYYrE8WWvBbtuSrkbpseVBj/pHI3T6oJSKBBC5LcF8s4++E5n5ScXNL
         DFJUrPyLvebMjGK5f5GsaTebg7UlSPSu16Sr0PQSsHxQ0y+9qg1SYLpaT7NNqdNqekJq
         3UwBIYpfGOsiljGzgVK9gBA8gsAcLY7w0xCs5qFR2XzEDL2P9biyn36vb5t3GWYd+IaC
         PmUdt4w5lTHUt714AmBhc6T+RZOivLpuI/v7x4rKli6eOvfJJcpwc9zxb5kLOe31ycJr
         0NEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gVxik1Rd2HR9YOH7lBv/JwMwx8oMND3FQlaYRrhj3M=;
        fh=Qwi4bkM/TcZNakyBIOP2hHL6j49r9ebjziY5QnZErxA=;
        b=jks0k1QkguaCu7o/v266/PtbJDWYAwBd6BwUMKSD83cwetN+qmhCZCUxx91NUr+dh+
         zM+Ht/bWLeVnGsmXiCvwPMqhZ9VTxx5byHwEZZJctRLcvWNmf/aDTlZz51LsietGiuxe
         KApTyf2hPf4CtNgQvDSQwE8ued/39JQ3I70AkIsVC8WHK4Rjdo84XGMLuc8+lqxKLh1K
         LAbNHJ27l+peyjl/HfqF99N+K9ZrGc+F4wHwZ6Dj0+Eu/DaduovJvcQ4dapQ6R/UEvzn
         MOm8MV6zNkPxgjyGREXdfz8OFguUKGYAS5qOBpWs7+k5Js2Fi1yAecpWDhJdQgijbJ3a
         RxCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770333492; x=1770938292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gVxik1Rd2HR9YOH7lBv/JwMwx8oMND3FQlaYRrhj3M=;
        b=KsFEC+5xJJ1pF6iyIreneP2yUGYbr5Zur8v5VVisrEy/PRfRqCg8Ov3FW/+TEjTr8o
         n1REryVfGIVanWoMukYiheyROgDhgCAgIyZfMlm7VDEN/yle6NhEVOEDE57kZffAxesC
         Om4gDAdHZ4bQKl+1AldcE4txCGAVoLrUOtNiWfZe05f+maskeO/svj51iRXy2wmnpP+L
         okCu1ynLqxC6TC9ZZT+SJa8UWFE9i8N+HOSntnvNnZFiAuxlH7UGiia+HJkT8TMXQlHJ
         Abgt4TgzhHGrQmrckg0ZYgrzx6jRVg4W+luCL/CQfxJSb42ImyCohYhWZc0GOaWI5DYn
         WvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333492; x=1770938292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gVxik1Rd2HR9YOH7lBv/JwMwx8oMND3FQlaYRrhj3M=;
        b=W0Ox7n2TyzuAOvc+SkTHCm/9P0huyq/EF4TGop2pykDU+WqVBNIoA4NLpSwoOWOGTb
         4DDu+wE55//BV7VIGaGUTxKVHtGXj4LqM+rm7+9gFcA5VJX7D+czgjBW9mpA1GMUDm4+
         kdBmCW2lXKK48GrYEexmHzICjkMQzlhSMJdveYTa7BZExtlzE9c6Ui9jAirizoAySEEQ
         QlbZsqXsQs7I2Kypzm4c9UI63lB2P81QyHAHEjuGaACX/WrYQkDPwTZBzFmEiFA60VWG
         Wbxyjmmxxy8sSIEC7HCihx2WU76p5IdWRJjlhJkIaokEdX1E/fxmqmYkqOHJoimsvVu4
         0N3A==
X-Gm-Message-State: AOJu0Ywb4yiG+BpoCsISQD73B9IPEIQN4/94seGY3uCO5mksSRUrW5nh
	9i1gchLkCazc4O4kj4h5nB76Sw4wgnCTK2uPpf0pm/LtfuZhrgqMGjCGaz4GnQH4sAqqlGR7oWF
	z6P3/3sSJzEzEGxLFe2ZPT0xUYLhNbO4=
X-Gm-Gg: AZuq6aKc2RfN/kQTRS1RsulCZWM/PU37KnzPn+E/l3uIrZAian+qSLulNDNJEV5Na2v
	3AMMA3DM+TxBky0tyZ5v9W7FiibR16EavfpRrTFcRGzy0pG0URyVoN7D7NlsYkpCheJoa7QIHed
	lZUV1DHk43s/+c/9N/vAX9m8DdgI4M0VDML6vweIZSyaRPCh4ydecOydZgclZWZDqzdNNQHq9Ez
	uAh+5Qx1oDTVXEQ0HQ+/dTOzA2CqD/6p94yGcos6rMWRacKK2tC3G1l6FnIsXl/zSEP7IGcmUFh
	1i8VT4ay/z0FVdLi1EPmhPDv/r9NgCP2yoSTOcQuyMz6qRx/jhh6/eV+LD/1DG+ay+kRBZCEhWX
	T6JgiXlVf1J2uGg==
X-Received: by 2002:a05:6000:25c5:b0:435:a160:4480 with SMTP id
 ffacd0b85a97d-436293b3972mr1289485f8f.29.1770333492352; Thu, 05 Feb 2026
 15:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-10-leon.hwang@linux.dev>
 <CAADnVQLXWQ8Miq2WBoXRDsEVP1QPwk=a5=Rj_uPN+9qKHZZmZw@mail.gmail.com> <11bb515b-35fd-44f3-9647-9c39580ce6a1@linux.dev>
In-Reply-To: <11bb515b-35fd-44f3-9647-9c39580ce6a1@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 15:18:01 -0800
X-Gm-Features: AZwV_QglFJ6RG-mGREyP1kc1aziDJK4mQg7BQEXe8BuO6fsVJnqTfOcc_yniLk8
Message-ID: <CAADnVQKYwi2bNc8Hsg-r9dF0ACYYEzRyZDc33G2Kr_o0bu3bow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 9/9] selftests/bpf: Add tests to verify map
 create failure log
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 7:54=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 5/2/26 04:14, Alexei Starovoitov wrote:
> > On Mon, Feb 2, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >> +
> >> +#define BPF_LOG_FIXED  8
> >> +
> >> +static void test_map_create(enum bpf_map_type map_type, const char *m=
ap_name,
> >> +                           struct bpf_map_create_opts *opts, const ch=
ar *exp_msg)
> >> +{
> >> +       const int key_size =3D 4, value_size =3D 4, max_entries =3D 1;
> >> +       char log_buf[128];
> >> +       int fd;
> >> +       LIBBPF_OPTS(bpf_log_opts, log_opts);
> >> +
> >> +       log_buf[0] =3D '\0';
> >> +       log_opts.log_buf =3D log_buf;
> >> +       log_opts.log_size =3D sizeof(log_buf);
> >> +       log_opts.log_level =3D BPF_LOG_FIXED;
> >
> > Why? Which part of the test needs the log with this flag?
>
> BPF_LOG_FIXED looks odd here.
>
> This test sets 'log_level =3D BPF_LOG_FIXED' to match the behavior of
> bpf_vlog_init() as initialized by bpf_log_attr_create_vlog() in
> patch #7. BPF_LOG_FIXED is intended to be the default log_level
> there.

I don't think you answered my question.
bpf_vlog_init() is using whatever log_level user space provided.
Why do you pass BPF_LOG_FIXED ?
