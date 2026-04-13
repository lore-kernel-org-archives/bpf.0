Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD102E11D2
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116531; cv=none; b=i9pxl21FDHDo+ycQOFDEs51UB8cMlh9PvagzJKxdiVvXCedUfMl9E8345+HGtAfGrPPVq4cbOEdmuub9sGNc6gzayJ0knKY6+JUBvVa7sEv1QzsZw/fY8QHypqfzGel9BnMtHThdYHQTmuD+smsFHVsZTPluSD4QB+kvHVK4EAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116531; c=relaxed/simple;
	bh=Mw7M/zfj9agdzbpXN0ZE+ckusBEzO4dFXALIF3lTV9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi3LdShY7OlWTt+3TVj2SdJlVX2JrHaL3+XcpcbQSLoGcoZdKV4piUfwqQg7PLjqrozw0933LShEFs2Gzks4lCsUbgL60BZRTcsAG8eJYHwp0pT52CeD0CB36iDrigFq/nlfw1XH312TQCvlptGvgPAsr1COJs6eqGiYEOqzvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roa0JyHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roa0JyHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AF7C2BCB6
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776116531;
	bh=Mw7M/zfj9agdzbpXN0ZE+ckusBEzO4dFXALIF3lTV9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=roa0JyHF+Dj0KbAsmHQPTmZ3gGpwjn0JqV/SmqK3S8JtJT2OzIuse/2rtosZn0Mzq
	 QjII2eJNfm8nHo9Z9pd2wOJ2IppKcXQO8MrGGiWaBlZDFrGFfrf9VlIMCj89Po8KC0
	 JejZIAB/ozc9fs/YqMRWt5TPWTjl7EBOl/egpzm4G4ww8KqTbQVNz5L4NDJSiRM8ka
	 Em/rl54OK1J7cZkAJPkYQM7UDTjArkiq1dXi0/wpjFOEmgq1r6DITRo779vqt+Dl5q
	 8OFhvZWC2Vna36KemELFgpQWdE8ykvBy5v90YgoAUEm9KCUjpRF1xGtj+ZIoKSmtk7
	 tMAMLL3y4Gi8w==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a151012558so60303566d6.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:42:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwOvWdEmInYGF0vfRLVWL3Z4dS2Tz+Wa+Sc8txTRFYIR/M248TN
	VOvNuFN1NiFWvnY5qxOPsYXjLbMvvbfwjN0Vv9QZQjzJ5JhEWqlyDxcw0F1JJ+LvbJnM/F2VeIO
	jPM92w5/2zqUlrz4zsMg0m/lGrtgkcho=
X-Received: by 2002:a0c:e004:0:b0:89c:4f7f:8479 with SMTP id
 6a1803df08f44-8ac861562e2mr213844056d6.6.1776116530549; Mon, 13 Apr 2026
 14:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org> <CALOAHbBpK7YBz2Y8YWL0=0dLz5DLUa003y4b8SMgB+BVjePeOw@mail.gmail.com>
In-Reply-To: <CALOAHbBpK7YBz2Y8YWL0=0dLz5DLUa003y4b8SMgB+BVjePeOw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 13 Apr 2026 14:41:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6-YEkJYKiC7M_jBsJWRT38B0AN0Y8x+yWKn9cHoVu=Uw@mail.gmail.com>
X-Gm-Features: AQROBzCUimfrEL9140NBST5UnSt8IIyWDYzYubGhwF0iPe1LZR1tpNr_DfG2IF0
Message-ID: <CAPhsuW6-YEkJYKiC7M_jBsJWRT38B0AN0Y8x+yWKn9cHoVu=Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, jolsa@kernel.org, kernel-team@meta.com
Content-Type: multipart/mixed; boundary="000000000000e23053064f5e5ad1"

--000000000000e23053064f5e5ad1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 1:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
[...]
> > +
> > +/* --- Module init/exit --- */
> > +
> > +static int __init test_klp_bpf_init(void)
> > +{
> > +       int ret;
> > +
> > +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> > +                                       &klp_bpf_kfunc_set);
> > +       ret =3D ret ?: register_bpf_struct_ops(&bpf_klp_bpf_cmdline_ops=
,
> > +                                            klp_bpf_cmdline_ops);
>
> Is it possible to integrate this BTF registration directly into
> klp-build? It appears we might need to extend scripts/livepatch/init.c
> to provide the necessary support.

Can you try the attached patch and see whether it works?

Thanks,
Song

--000000000000e23053064f5e5ad1
Content-Type: application/octet-stream; name="klp-build.patch"
Content-Disposition: attachment; filename="klp-build.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mnxpw6ng0>
X-Attachment-Id: f_mnxpw6ng0

ZGlmZiAtLWdpdCBpL3NjcmlwdHMvbGl2ZXBhdGNoL2tscC1idWlsZCB3L3NjcmlwdHMvbGl2ZXBh
dGNoL2tscC1idWlsZAppbmRleCA3YjgyYzc1MDNjMmIuLjYyMDFmOTllNGQwNSAxMDA3NTUKLS0t
IGkvc2NyaXB0cy9saXZlcGF0Y2gva2xwLWJ1aWxkCisrKyB3L3NjcmlwdHMvbGl2ZXBhdGNoL2ts
cC1idWlsZApAQCAtNTY2LDYgKzU2NiwxMSBAQCBjb3B5X29yaWdfb2JqZWN0cygpIHsKIAlkb25l
CiAJeHRyYWNlX3Jlc3RvcmUKIAorCSMgU2F2ZSB2bWxpbnV4IGZvciBCVEYgYmFzZSByZWZlcmVu
Y2Ugd2hlbiBnZW5lcmF0aW5nIG1vZHVsZSBCVEYKKwlpZiBbWyAtdiBDT05GSUdfREVCVUdfSU5G
T19CVEZfTU9EVUxFUyBdXSAmJiBbWyAtZiAiJE9CSi92bWxpbnV4IiBdXTsgdGhlbgorCQljcCAt
ZiAiJE9CSi92bWxpbnV4IiAiJE9SSUdfRElSL3ZtbGludXgiCisJZmkKKwogCW12IC1mICIkVE1Q
X0RJUi9idWlsZC5sb2ciICIkT1JJR19ESVIiCiAJdG91Y2ggIiRUSU1FU1RBTVAiCiB9CkBAIC03
MTUsNiArNzIwLDM2IEBAIGRpZmZfY2hlY2tzdW1zKCkgewogCWRvbmUKIH0KIAorIyBSZWdlbmVy
YXRlIEJURiBmb3IgdGhlIGxpdmVwYXRjaCBtb2R1bGUKK2dlbl9tb2R1bGVfYnRmKCkgeworCWxv
Y2FsIGttb2RfZmlsZT0iJDEiCisKKwkjIFVzZSB0aGUgb3JpZ2luYWwgKHByZS1wYXRjaCkgdm1s
aW51eCBhcyBCVEYgYmFzZSwgc2luY2UgdGhlIG1vZHVsZQorCSMgd2lsbCBiZSBsb2FkZWQgb24g
YSBrZXJuZWwgcnVubmluZyB0aGF0IHZtbGludXguICBUaGUgcGF0Y2hlZCB2bWxpbnV4CisJIyAo
Y3VycmVudGx5IGF0ICRPQkovdm1saW51eCkgaGFzIGRpZmZlcmVudCBCVEYgc3RyaW5nIG9mZnNl
dHMuCisJbG9jYWwgYnRmX2Jhc2U9IiRPUklHX0RJUi92bWxpbnV4IgorCisJW1sgISAtZiAiJGJ0
Zl9iYXNlIiBdXSAmJiB7IHdhcm4gIm9yaWdpbmFsIHZtbGludXggbm90IGZvdW5kLCBza2lwcGlu
ZyBCVEYiOyByZXR1cm47IH0KKworCSMgZ2VuLWJ0Zi5zaCBpcyBhIHN1YnByb2Nlc3MgYW5kIG5l
ZWRzIHRoZXNlIHZhcmlhYmxlcyBleHBvcnRlZC4KKwkjIFF1ZXJ5IHRvb2wgcGF0aHMgYW5kIGZs
YWdzIGZyb20ga2J1aWxkIHJhdGhlciB0aGFuIGhhcmRjb2RpbmcKKwkjIHRoZW0sIHNpbmNlIHRo
ZXkgdmFyeSB3aXRoIExMVk09IGFuZCBDUk9TU19DT01QSUxFPS4KKwlsb2NhbCBwYWhvbGUgb2Jq
Y29weSBwYWhvbGVfZmxhZ3MKKwlwYWhvbGU9IiQoY2QgIiRTUkMiICYmIG1ha2UgLXMgLS1uby1w
cmludC1kaXJlY3RvcnkgXAorCQktLWV2YWw9J3ByaW50LXZhcjogOyBAZWNobyAkKFBBSE9MRSkn
IHByaW50LXZhciAyPi9kZXYvbnVsbCkiCisJb2JqY29weT0iJChjZCAiJFNSQyIgJiYgbWFrZSAt
cyAtLW5vLXByaW50LWRpcmVjdG9yeSBcCisJCS0tZXZhbD0ncHJpbnQtdmFyOiA7IEBlY2hvICQo
T0JKQ09QWSknIHByaW50LXZhciAyPi9kZXYvbnVsbCkiCisJcGFob2xlX2ZsYWdzPSIkKGNkICIk
U1JDIiAmJiBtYWtlIC1zIC0tbm8tcHJpbnQtZGlyZWN0b3J5IFwKKwkJLS1ldmFsPSdwcmludC12
YXI6IDsgQGVjaG8gJChQQUhPTEVfRkxBR1MpJyBwcmludC12YXIgMj4vZGV2L251bGwpIgorCisJ
UEFIT0xFPSIkcGFob2xlIiBQQUhPTEVfRkxBR1M9IiRwYWhvbGVfZmxhZ3MiIE9CSkNPUFk9IiRv
Ympjb3B5IglcCisJUkVTT0xWRV9CVEZJRFM9IiRPQkovdG9vbHMvYnBmL3Jlc29sdmVfYnRmaWRz
L3Jlc29sdmVfYnRmaWRzIgkJXAorCVJFU09MVkVfQlRGSURTX0ZMQUdTPSItLWRpc3RpbGxfYmFz
ZSIJCQkJCVwKKwlvYmp0cmVlPSIkT0JKIiBLQlVJTERfVkVSQk9TRT0iIgkJCQkJXAorCQkiJFNS
Qy9zY3JpcHRzL2dlbi1idGYuc2giIC0tYnRmX2Jhc2UgIiRidGZfYmFzZSIgIiRrbW9kX2ZpbGUi
CVwKKwkJfHwgZGllICJCVEYgZ2VuZXJhdGlvbiBmYWlsZWQiCit9CisKICMgQnVpbGQgYW5kIHBv
c3QtcHJvY2VzcyBsaXZlcGF0Y2ggbW9kdWxlIGluICRLTU9EX0RJUgogYnVpbGRfcGF0Y2hfbW9k
dWxlKCkgewogCWxvY2FsIG1ha2VmaWxlPSIkS01PRF9ESVIvS2J1aWxkIgpAQCAtNzgxLDEyICs4
MTYsMjIgQEAgYnVpbGRfcGF0Y2hfbW9kdWxlKCkgewogCSMgU2F2ZSBvZmYgdGhlIGludGVybWVk
aWF0ZSBiaW5hcnkgZm9yIGRlYnVnZ2luZwogCWNwIC1mICIka21vZF9maWxlIiAiJGttb2RfZmls
ZS5vcmlnIgogCi0JIyBXb3JrIGFyb3VuZCBpc3N1ZSB3aGVyZSBzbGlnaHQgLmNvbmZpZyBjaGFu
Z2UgbWFrZXMgY29ycnVwdCBCVEYKLQlvYmpjb3B5IC0tcmVtb3ZlLXNlY3Rpb249LkJURiAiJGtt
b2RfZmlsZSIKKwkjIFJlbW92ZSBCVEYgc2VjdGlvbnMgZnJvbSB0aGUga2J1aWxkIE09IGJ1aWxk
LiAgVGhleSB3ZXJlIGdlbmVyYXRlZAorCSMgYWdhaW5zdCB0aGUgcGF0Y2hlZCB2bWxpbnV4IGFu
ZCB3aWxsIGJlIHJlZ2VuZXJhdGVkIGJlbG93IGFnYWluc3QKKwkjIHRoZSBvcmlnaW5hbCB2bWxp
bnV4LgorCW9iamNvcHkgLS1yZW1vdmUtc2VjdGlvbj0uQlRGCQlcCisJCS0tcmVtb3ZlLXNlY3Rp
b249LkJURi5iYXNlCVwKKwkJLS1yZW1vdmUtc2VjdGlvbj0uQlRGX2lkcwlcCisJCSIka21vZF9m
aWxlIgogCiAJIyBGaXggKGFuZCB3b3JrIGFyb3VuZCkgbGlua2VyIHdyZWNrYWdlIGZvciBrbHAg
c3ltcyAvIHJlbG9jcwogCSIkU1JDL3Rvb2xzL29ianRvb2wvb2JqdG9vbCIga2xwIHBvc3QtbGlu
ayAiJGttb2RfZmlsZSIgfHwgZGllICJvYmp0b29sIGtscCBwb3N0LWxpbmsgZmFpbGVkIgogCisJ
IyBSZWdlbmVyYXRlIEJURiBhZnRlciBwb3N0LWxpbmsKKwlpZiBbWyAtdiBDT05GSUdfREVCVUdf
SU5GT19CVEZfTU9EVUxFUyBdXTsgdGhlbgorCQlnZW5fbW9kdWxlX2J0ZiAiJGttb2RfZmlsZSIK
KwlmaQorCiAJY3AgLWYgIiRrbW9kX2ZpbGUiICIkT1VURklMRSIKIH0KIAo=
--000000000000e23053064f5e5ad1--
