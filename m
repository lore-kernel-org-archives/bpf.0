Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943525;
	b=XdUaJafzgDbsCZ+3PLvW9h5LrhqU7zfZkxV29a+OWjdBiJR0KLHsXw+CeuvRI7KYVIHD
	 R0aCGBqMQKc/pUG6c+R04b6MOfMiPAmU3fa/SK3g8K9J/canMzIjZOC9KtGaba5e/0Kg2
	 9SavB+gI8Zen63yfIx4SF4/yOlv1SKq1IjsbDBlhT6mAXzWAO4qsBpuov2blmOp1ctRzd
	 erkLKun+Q0PY21W7q7Zj85inH2sYiIC/uu847zOFve//wBqVr/IEhoapo4/BGmSag0wu4
	 EFKiKJYD8HQtQFFqOocLDTzS36sn1M5Zz5lTscZ5LwJ0EVRtVaSsM0nQo4s8fKx3N5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=F9hrTAryckkRNWpmMvC13Oo9jyAmVkaUqByUV80MHJE=;
	b=WEdZwmPZUkOw+UNBFIvBy7tR9AgFJjpSwR2dFBc2X/hYbMVzrr9TCrco7TvdKNQXGI3o
	 6xzEw7A19Z1zMDBFhHNUo47TYb/d7A5TffoK0Fv9OsVQcSpM8vL3rCTE8SbQd9vWAY8im
	 /fXd5275vgElscK7eLCQJLeGWREfF5OZCerFX09V8qRLGyIpl9r09wkJTJGWhs9sBnxfE
	 NUzLM48beZSmBwQSTew9kdWcS2JYz6WvPzhCUNbFJsL6e7f+r1fZ0nZfFE2Q4bmJLvLFj
	 Eq94Bs7BTHs3sA4koAAROJoPcK2hvzHomjA1/ynOLKqMTWwKBBWRo80pZQ7MFxwJgqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=scarletmail.rutgers.edu;
	spf=pass smtp.mailfrom=scarletmail.rutgers.edu;
	dkim=pass header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=NDcom4ki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63918606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63918606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=NDcom4ki
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ec396c93dso796976d6.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794943524; cv=none;
        d=google.com; s=arc-20260327;
        b=KgnPfF0d1ElZ5lCBxB1xdOwAM0ApUHrNVC4zMzx9WzkyU0sfvgFU01Q91BI8yvMddH
         JVhw7m6kvVU3kVDGjC3XX0ufqv515uWhIplXnOLv6/huDV61vJEIs1irDvkwDNCyVbQ+
         tyE4+tawsS52xm1fZJ1NvQLOy779u0c2iW6Dk2y34sxmFN7w/bGFoWbMFBEV2cnwrjRR
         vBUbulem6a7qlB2MIGBZ/kYAniH0fiWkv//qe3iw1TrF+vnajV7jJrDqIybVnjdL13q4
         GFngtKHuGp6AdN652UmrkBe6naLrdGI8SuyCWcjYc5gvHqdgR/TEMVj+Mb75SLSHcqoP
         JAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=F9hrTAryckkRNWpmMvC13Oo9jyAmVkaUqByUV80MHJE=;
        fh=DVImKLhcKuounm3K9Xgg4J3osERFJhthSzUJqfpBQU4=;
        b=azCJq2UuDKszpPFCY643Scak68HWgdtWTQTcrlsfjnVbbwzccD2EuuRmdHPYDIbDr/
         yehStIvFPQclzRO/NS2K9wzbhj5g2kjEE7PPXn6Gj7DVALPXSIVM5h99QgJVSZskogg4
         q5Z81nSyQ/1PBCV7c8KdpfNJBPZ71lACCTZvA03C/PJC4weap8/CsVZOIde3Vdxn7U75
         oXoykH7pCRWK35Ccbm6Mr92/4hZcJXIWMhE2g6Frs1SeLVqccATJUfh4KVP5XEGseZLF
         nah46xWNneqCcdu0btde1eUZ15A4n2c4SWpGakV86/Xy2ujMpol9Gf3Ikk9mVb86/vzy
         LXZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529; t=1794943524; x=1795548324; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F9hrTAryckkRNWpmMvC13Oo9jyAmVkaUqByUV80MHJE=;
        b=NDcom4kirHcnkdsmxEwYF3JXXMYofG+jKgnAmHUbi9aG8+K0EpiWeWKEzsW/8xOQYx
         fjVQ/GtRSsbEFcPVIW1WfSrKPtAxlBoqNwGaZiFOnEm9zk6N5IOJIj+QMCrcUVeOawXY
         NN3RnQK+/V1IUl1hl9mizmRWN0Y0IwBvHUs95IBN/1HMG0ETcVF7FhDQfhuwfnpm44uQ
         oTmKzFztQ3Ml+OTMRP4PvLgia+ENqRS8ui0p2j2a17hIZKHD26q1M77dtNnaL6O1jJLn
         a9IsbP0jzRFabeThUdgCfWj7ncygKA3qS8WfePJtmYCpIfRkEEI44bLAXu963tQdoIQR
         P25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943524; x=1795548324;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F9hrTAryckkRNWpmMvC13Oo9jyAmVkaUqByUV80MHJE=;
        b=2CyCYOfqkqFow6vRd3qGejwywaoaFu5QRt+PH19Un2ZFHflaqLfCHjwGcsu+Bq16IG
         /Kf9lx9UHXbo7clpZpRbBA7gZXhdGczP4F6fb9vXN7OjUF+t+qR4PXlUBjTxsbctphks
         zvUzYWZWJXrG6XJIlWs/niMWejBhuTiihCfh0MZlHbtCuQ5sszqAHFiNHVIBUDzmvaSX
         lT4ezAo5qf/d9A4138flZ552SMnnOwoHR4w9sqCMXGwsmR0xJGUA0NJH70dz7Zit/BgD
         /NC8CtaNsngR+La2QuU9LzFrMqutzHIrDwwHUSk3e44JLwed8P3BtCngFHY7uZpdVeEm
         3zuQ==
X-Gm-Message-State: APuU4Z9DGMCKqnOeE0k2JNwpAe53VqNZZ6okos//KwIvC2tWynShlSFF
	dApk9y4sufieDnnF5MEITpaKkOtFQ8uWyMg4BwcUxOP/Bo5o2sNEk9Q5LYU7pAzzp5vbLsr3q6w
	oXhwbihuR5pRHJvS71jdUgpERG1bNBCPOGK4emX/aYPDajQFqrkq+2SZPcA==
X-Gm-Gg: AZFdTZcErUeT/z1fDVAMY6VbvK65EYhB73gjGn5tgYNXT2EfAJX/nl9kv+u/oIzhpSr
	S2f15AMBE7OqVPnykA8zPDxP2jNP1IEUX3Ako3/gw7NDIzXi8Frv0M8FkNrku92SRbydlrFFW1Y
	aqbsBpokVdZrSIGZm0Ix894kugkNIr3OT/x/POAKQaUfNruHI3oUFD/HKzWn2e+HZ4/A09GY1g3
	f+vppNAkcc6Mx59SEW+OD6AFxGBpZhuru+EtzaTh0VcV1Gcsc5+xhRdCTwZDzfRv1fGA5B1e3d4
	hVZL/06AFV9IhuXC7Hxnx99wBkxWiCMk6/VprZfBsMgCh/S+rM/uFrQL77JTvsx0U+oUIZN9hy+
	tCQBD7XIdWMLy/lcEHNWX0C5w1c/ejBpTsvxhrrSv5z6HaPL+J03wCLY6eUFnyJK+wYgfYjGA
X-Received: by 2002:a05:6214:262e:b0:91e:9853:7f2a with SMTP id
 6a1803df08f44-92114deb590mr3269446d6.16.1794943523734; Tue, 17 Nov 2026
 11:25:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yalu Cai <yc1795@scarletmail.rutgers.edu>
Date: Tue, 17 Nov 2026 14:25:12 -0500
X-Gm-Features: Aa3M54qszekGUkY2OaCs5bvCR8uYSWf9LB5FmdtJSX3VRrHP2_Zhm_p8tcXXJv4
Message-ID: <CAPUfTJPd27eD4=CjG9-1oCnVCYrUXiRrrcpPFz2K86W1e+Ytmw@mail.gmail.com>
Subject: tracepoint programs can read ctx at negative offsets
To: bpf@vger.kernel.org
Cc: santosh.nagarakatte@cs.rutgers.edu
Content-Type: multipart/mixed; boundary="00000000000020a58a06607ddb5d"

--00000000000020a58a06607ddb5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

As part of a research project, we have been trying to formally verify parts
of the eBPF verifier. We found a bug that can read ctx at negative offsets.
Below is the concrete description of the bug:

tp_prog_is_valid_access() lets a tracepoint program read 8 bytes in front
of its context. The read lands on the per-CPU trace buffer's neighbor. For
a syscall tracepoint it lands on the kernel stack next to the record. The
program can then read a kernel text address out of it. I found it in 7.4-rc=
3
and bpf-next (ea80d2afd285).

In kernel/trace/bpf_trace.c, the lower-bound check is

=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82static bool tp_prog_i=
s_valid_access(int off, int size, ...)
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82if (off < sizeof(void *) || off >=3D PERF_=
MAX_TRACE_SIZE)
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82return false;
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82...
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82if (off % size !=3D 0)
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82return false;

There is no explicit negative offset check. Since sizeof(void *) is unsigne=
d,
off =3D -8 passes this lower-bound check. The verifier accepts this access:

=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82SEC("tracepoint/sysca=
lls/sys_exit_read")
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82r0 =3D *(u64 *)(r1 - =
8)
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82r0 =3D 0
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82exit

The equivalent load at r1 + 0 is rejected with "invalid bpf_context access
off=3D0 size=3D8". The negative-offset load is accepted.

I attached a program to sys_exit_read that copies r1[-8] into an array map.
On a 7.4-rc3 x86_64 guest, the map held 0xffffffffa477766a, which
/proc/kallsyms resolves to perf_call_bpf_exit+0x6a. This reads a kernel tex=
t
address and discloses it despite KASLR. The memory is mapped, so it does no=
t
crash.

Loading a tracepoint program needs CAP_PERFMON, which also grants
bpf_probe_read_kernel(). A program with that capability can already read
kernel memory. The verifier issue is that it accepts a context access
outside the context.

The check should reject negative offsets, as the other tracing types do.

=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (off < 0 || off < =
sizeof(void *) || off >=3D PERF_MAX_TRACE_SIZE)
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82return false;

The check has been this way since 9fd82b610ba3 ("bpf: Add BPF_PROG_TYPE_
TRACEPOINT", 2015).

Thanks,
Yalu

--00000000000020a58a06607ddb5d
Content-Type: application/octet-stream; name="prog.c"
Content-Disposition: attachment; filename="prog.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mwl30p0m0>
X-Attachment-Id: f_mwl30p0m0

Ly8gQSB0cmFjZXBvaW50IHByb2dyYW0gcmVhZHMgdGhlIDggYnl0ZXMganVzdCBiZWZvcmUgaXRz
IGNvbnRleHQgYW5kIGNvcGllcwovLyB0aGVtIGludG8gYSBtYXAuIHRwX3Byb2dfaXNfdmFsaWRf
YWNjZXNzIGNvbXBhcmVzIGEgbmVnYXRpdmUgb2Zmc2V0IHdpdGgKLy8gc2l6ZW9mKHZvaWQgKikg
YXMgYW4gdW5zaWduZWQgbnVtYmVyLCBzbyBvZmYgPSAtOCBwYXNzZXMuIEZvciBhIHN5c2NhbGwK
Ly8gdHJhY2Vwb2ludCB0aGUgcmVjb3JkIGlzIGEgbG9jYWwgb24gdGhlIGtlcm5lbCBzdGFjayAo
cGVyZl9jYWxsX2JwZl9leGl0KSwKLy8gYW5kIHRoZSBsb2FkIHJlYWRzIHRoZSBzdGFjayBuZXh0
IHRvIGl0OiBhdCBzeXNfZXhpdF9yZWFkLCBhIHJldHVybgovLyBhZGRyZXNzIGludG8ga2VybmVs
IHRleHQsIHdoaWNoIGRlZmVhdHMgS0FTTFIuCi8vIEtleSAwIG9mIGVhY2ggbWFwIGhvbGRzIHRo
ZSBsYXN0IHZhbHVlIHJlYWQsIGtleSAxIGNvdW50cyB0aGUgcnVucy4KI2luY2x1ZGUgInBvYy5o
IgoKc3RydWN0IG91dF9tYXAgewoJX191aW50KHR5cGUsIEJQRl9NQVBfVFlQRV9BUlJBWSk7Cglf
X3VpbnQobWF4X2VudHJpZXMsIDIpOwoJX190eXBlKGtleSwgX191MzIpOwoJX190eXBlKHZhbHVl
LCBfX3U2NCk7Cn07CnN0cnVjdCBvdXRfbWFwIG91dCBTRUMoIi5tYXBzIik7CgojZGVmaW5lIFJF
QURfQkVGT1JFKE1BUCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCglhc20gdm9sYXRpbGUgKCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAoJInI2ID0gKih1NjQgKikocjEgLSA4KTsiICAgLyogOCBi
eXRlcyBiZWZvcmUgdGhlIGNvbnRleHQgKi8gICAgICAgIFwKCSJyMSA9IDA7IiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCgkiKih1MzIg
KikocjEwIC0gNCkgPSByMTsiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAoJIioodTY0ICopKHIxMCAtIDE2KSA9IHI2OyIgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKCSJyMiA9IHIxMDsiICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCgkicjIgKz0gLTQ7IiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAoJInIzID0gcjEwOyIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
CSJyMyArPSAtMTY7IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCgkicjQgPSAwOyIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXAoJInIxID0gJVttXSBsbDsiICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKCSJjYWxsICVbYnBmX21hcF91
cGRhdGVfZWxlbV07IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCgkicjEg
PSAxOyIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXAoJIioodTMyICopKHIxMCAtIDQpID0gcjE7IiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKCSJyMiA9IHIxMDsiICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCgkicjIgKz0gLTQ7IiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAoJInIxID0gJVtt
XSBsbDsiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKCSJjYWxsICVbYnBmX21hcF9sb29rdXBfZWxlbV07IiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCgkiaWYgcjAgPT0gMCBnb3RvIDFmOyIgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXAoJInIxID0gMTsiICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKCSJsb2NrICoodTY0ICop
KHIwICsgMCkgKz0gcjE7IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCgki
MTogcjAgPSAwOyIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXAoJImV4aXQ7IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKCTo6IF9faW1tKGJwZl9tYXBfdXBkYXRlX2VsZW0pLCBf
X2ltbShicGZfbWFwX2xvb2t1cF9lbGVtKSwgICAgICAgICBcCgkgICBbbV0gImkiKCZNQVApICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAoJOiBfX2Ns
b2JiZXJfYWxsKQoKU0VDKCJ0cmFjZXBvaW50L3N5c2NhbGxzL3N5c19leGl0X3JlYWQiKQpfX25h
a2VkIGludCBiZWZvcmVfY3R4KHZvaWQpIHsgUkVBRF9CRUZPUkUob3V0KTsgfQo=
--00000000000020a58a06607ddb5d--
