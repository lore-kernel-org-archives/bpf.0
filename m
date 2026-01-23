Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CC1F419F
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194494; cv=pass; b=ABHNTgtq9nR3oaO9DN4uz40CEn8e17E2dYS0s6GIWuEDAvhjufMhWsMi6VK4G/hCLn6l6feoS0bTcFfCzSG3XRhhiK+q4+QXasjRSpHDwhVoJr9OhJGFaQg/tQeRYDZWbAywlM0PHTDOt/z2Y5gWt0pyAjCQzTu/toVrhV2Zg9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194494; c=relaxed/simple;
	bh=mogKnU+/3Gpm3+TCKIivbq94eYQH9qfmDATkiFrBSF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qv+zCHGp7dZzrQYFkL+1XkFup/FgxdEaZ60Jr12Nus9BaxkPU1m+kEEXtphL08Pro/MdKxxbdUP1Y3Zbs9w7NKz440b6y/CXb/2t54c+bA1q2t4kdDBQWbdW7ZCG+Hon84/ExWX6jvhzsn8SnYOGYxaPyE8rdX0cByNnRz+MHho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azPsTssj; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azPsTssj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3530715386cso2372049a91.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194492; cv=none;
        d=google.com; s=arc-20240605;
        b=NRg8tgNA5rQP2tHS4N4py8MEDWC1UqccuMGguKdVnPZZ2p25cb/qT3hExUI7BbplCD
         HiJjnUiaUHVaHtAU6pAapbOtDnm37SnE0PH2TZoOJdA5HQjBCjIozBLCxmxZ0DlFHWIk
         VxUwBm+qyLPuNXC+C+sfjNNmGWZS8tZWvECFQGOqxZf0KZHfMgY6M3x70UYOg0BBPAf+
         JIQu3KZypiFGPaVMkJ3sTFyvGUlP8gqk/8scLaGt8lYDM6GtbpNgjr7TtLlDvSCIMXep
         57bqPWLCxLmUkU47hm6deEosXqwpnNS9gGMr2g1QlLJohbqe0zOj+Bvf6hmqvrokzxKa
         BUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYmPiHRJ1VjBncSc3bQynnNatD06b0uPrSBt7EelaoA=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=GXSLOunrA1D9ltsnDo4mMKwN54G5vAfM5MDjdBdkO5IApEWQifq4zctj/uji5CuTC3
         RdxuRNC5hZbmQGSRhq14aWP55eRWc5AhXBhni2gC5ZSzUBTOX6hLOQAlaS8XTI3M/TvK
         35tZIQ9NmTpDN57a+fqEpdg3hbCj1WmEavvjIPEipfcfIzDc36JvjhaRfr1pCud45J6i
         jHaqy97bjTkJYKXgFvwLwj1Ov0KzdSPwXdVOigbtInYhO5XASqZBJCf2udhmng4DxC3x
         3c9N198LuLfdDVr7Oo1dHWZ79qDIdj6bmtZyfDd9+B84DkLNNxC85ty0MctZqQ7uB7UX
         i4+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194492; x=1769799292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYmPiHRJ1VjBncSc3bQynnNatD06b0uPrSBt7EelaoA=;
        b=azPsTssjg29Vs4wLIzjZFP/Nk7GTIgAVC6iGTmAsj/Hdad1VkjZOiD40/raEvsR7EQ
         m1C7G0U/VR6gnEK/XAVgODZv5CtipRqMWBH/w8zyhzclos3II7dZcU9Puf1q1bp4My5e
         My8iN39aZW4dAKY2ZsGrpdZX2Ggana5AXE5ZVrMo+nsoAu4sXr+TSG0egBc75vzUc4Wb
         /H3VHK2+pqTWROAiKWmxAXRQr4q4PbpyTZg/XN0olDw6myZhQ3+7tp0mFdGYOBDpeSL/
         9EtbtSPoxvC62QfRyNwm6RT1b+7gk/k/IMNM7f0c+cFrVX5GJVVmHikkGT4db04ufPnJ
         iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194492; x=1769799292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYmPiHRJ1VjBncSc3bQynnNatD06b0uPrSBt7EelaoA=;
        b=fDGiAX3kEv/SGuZVp/W/blXugaVQxp9CF5ETlLkIxGRgs3OMTUvIQUW5vT4GEZ4zN2
         nuHVHQ4h2LfP9H0G8T0BtOUZxhtC/u5E9gOPmr5TvosJ4QGiyig4BIyHp4dutP/9WC17
         uAdC+ICy9hTq1zvje2Vij0yw06QR+xNx4Zk/M8pb841GpLXugP5si/wOFWxyOrQ1Cyut
         0m3UVf3NWGn5UVg22RzNTrG0yFfrkpLM+YWBjAcsYbm5A8ag99ANLGuepfXXvqf3Wzue
         ien69tq41wi0YBXJxRJ/qgdB5NOzWf+jP5kpfkQ2wo/nlmrEzhYwoLVQsLFoy7helmOo
         BP9Q==
X-Gm-Message-State: AOJu0YwjTascZQavdmn+XRMfAfAJd1WVVqYwE7TYX7LqnDAoOxsE5B5U
	zE0ojTS6/Vv/2Yi0UOBSB/bIvm1mXkN+eFylY5q7cpXU2Dp2A8nVmaG8kq2oYTN1rkeBOSJlM5Q
	P/wthlk/qJwlcP0/aLTJXqNq934KRt0E=
X-Gm-Gg: AZuq6aICqOkDMglJzbeEUBGV51wWuDWG3NOEzyJUxT0Cw0yECTwg1Q32/8AvbKQf6JK
	qbN/FGaJf9NezTyzPq4DuxYLnx4OIgpqjNMRxMmtrdTW+nHMi4pVXFpRy+mO+CrdruBO0PTs6vA
	PgymKCXDAfUgjg/K3ZTyhsLHem/MTx0D1pBSZJ7zMQgDNwIi0SLVhu2lf8bH9KiQMgh6G3hbVHZ
	zqkuf0ajRaIa1d5IoEPLt6I1k2My3smESkZ/dxPjZkFSstTwWV9w2zPOUaLQ1z+0LV2IPibewWJ
	xZm/hn9T1Ck=
X-Received: by 2002:a17:90a:e185:b0:349:5b1b:78be with SMTP id
 98e67ed59e1d1-353688574b1mr3895164a91.17.1769194491806; Fri, 23 Jan 2026
 10:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152424.40766-1-leon.hwang@linux.dev> <20260120152424.40766-3-leon.hwang@linux.dev>
 <CAEf4BzYuZsFC-DPhhzLcyFTahucHP59+6kAc0sooY2g+SqgrEA@mail.gmail.com> <d8f37588-2b7d-447a-ae4f-dc81e1b573c5@linux.dev>
In-Reply-To: <d8f37588-2b7d-447a-ae4f-dc81e1b573c5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 10:54:37 -0800
X-Gm-Features: AZwV_Qi3JozEFDMkX_Qj_HRM7VamKhm_b4P9yeRYSoUDV7xr3lmnoWFfgWxKG6U
Message-ID: <CAEf4Bzb_V4p7XvE6e2CUfbKhfjh96i-_mCYa-osWiSGwWObmrQ@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v6 2/9] libbpf: Add support for extended
 bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
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
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 5:41=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 23/1/26 08:53, Andrii Nakryiko wrote:
> > On Tue, Jan 20, 2026 at 7:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> To support the extended BPF syscall introduced in the previous commit,
> >> introduce the following internal APIs:
> >>
> >> * 'sys_bpf_ext()'
> >> * 'sys_bpf_ext_fd()'
> >>   They wrap the raw 'syscall()' interface to support passing extended
> >>   attributes.
> >> * 'probe_sys_bpf_ext()'
> >>   Check whether current kernel supports the BPF syscall common attribu=
tes.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c             | 32 ++++++++++++++++++++++++++++++++
> >>  tools/lib/bpf/features.c        |  8 ++++++++
> >>  tools/lib/bpf/libbpf_internal.h |  3 +++
> >>  3 files changed, 43 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index 21b57a629916..ed9c6eaeb656 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -69,6 +69,38 @@ static inline __u64 ptr_to_u64(const void *ptr)
> >>         return (__u64) (unsigned long) ptr;
> >>  }
> >>
> >> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> >> +                             unsigned int size,
> >> +                             struct bpf_common_attr *attr_common,
> >> +                             unsigned int size_common)
> >> +{
> >> +       cmd =3D attr_common ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_C=
OMMON_ATTRS);
> >> +       return syscall(__NR_bpf, cmd, attr, size, attr_common, size_co=
mmon);
> >> +}
> >> +
> >> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *at=
tr,
> >> +                                unsigned int size,
> >> +                                struct bpf_common_attr *attr_common,
> >> +                                unsigned int size_common)
> >> +{
> >> +       int fd;
> >> +
> >> +       fd =3D sys_bpf_ext(cmd, attr, size, attr_common, size_common);
> >> +       return ensure_good_fd(fd);
> >> +}
> >> +
> >> +int probe_sys_bpf_ext(void)
> >> +{
> >> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_toke=
n_fd);
> >> +       union bpf_attr attr;
> >> +
> >> +       memset(&attr, 0, attr_sz);
> >> +       /* This syscall() will return error always. */
> >
> > I'll cite myself from the last review:
> >
> >> But fd should really not be >=3D 0, and if it is -- it's some problem,
> >> so I'd return an error in that case to keep us aware, which is why I'm
> >> saying I'd just return inside if (fd >=3D 0) { }
> >
> > I didn't say let's just ignore syscall return with (void) cast and
> > happily check errno no matter what, did I? Drop the comment, and
> > handle fd >=3D 0 case explicitly, please.
> >
>
> My mistake =E2=80=94 sorry for the misunderstanding.
>
> You=E2=80=99re right; the return value should not be ignored. In the next
> revision, I=E2=80=99ll handle the fd >=3D 0 case explicitly and drop the =
comment.
> The logic will be updated along the lines of:
>
> fd =3D syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS,
>              &attr, attr_sz, NULL, sizeof(struct bpf_common_attr));
> if (fd >=3D 0) {
>         close(fd);
>         return 0;
> }
> return errno =3D=3D EFAULT;
>

well no, it should be

fd =3D syscall(...);
if (fd >=3D 0) {
    close(fd);
    return -EINVAL;
}

return errno =3D=3D EFAULT ? 1 : 0;

> Thanks,
> Leon
>
>
