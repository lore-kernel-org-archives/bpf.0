Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D07218845
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777117689; cv=none; b=AkAQQl44gE3OPKoY4GKOfrw8EOCSzFg+at5PwqCemtwxBdemqzgUDhzVbDdysX4N8kV0xJK8H9+e+HOjCRwUujGTiZ8zmXzf/Fp67g9sZCQN9vM5tSqYrlfMQ6FG+W9QB5wYRbcFXYDC2xpdLJJmANs5GUQ4tRV08mp5+bopY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777117689; c=relaxed/simple;
	bh=/ZeGy/Flug2lryL0vEEyGpP8YDNBWJJ+qhsFRGvCsrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j7TIcb+E27bbHgXKXulqsT5sSrnKsXZllo0g4Jujuc8zNOKGF0DrN/gZTteBkGwDN0z/fq8/wiSft3GtccYMisc2kmLxpI3v9HgoLBUb1bo7mrMqpdOwhJTcerGU1lm3SMPiagYYK11ieki3FNY5BmYbyZOiP0QcmseLypQM5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aztZzXTd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aztZzXTd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso6015531a91.0
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777117687; x=1777722487; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OcEACDd46McVoFN2dvZzK9b4vFCI19K7E/hzzjVumjc=;
        b=aztZzXTdjlB7dHjhvMzxyF600dYpUgGExtOFw6NZWGV27oO1GS8ktYumG6LLzAAlhA
         hLIAsUT6gbIWYpYJE1rQx+i0EuWfx9BjuRu4a1WPUaOm3ganB69hKg4M3aIPNcqvvSr7
         HQvX1XaEhw72ofZtIPLH1p4q81hj+QcS4hv4BFuxfIM5cLWMAZpFfJgNcjHIKLHgnK55
         2VPev/KuPZEK30EZPmjUyonUNGdZ9ogTBa0h4TpDYKx5jhWlVeiGGVctCGhdp5aKKQRD
         YPG0VM5Nytz8EK+vQ5LkLSjpIHHK1dVUrzYYfhcj47Ok3inUFTGBThgm3cEp7hOynp93
         rEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777117687; x=1777722487;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OcEACDd46McVoFN2dvZzK9b4vFCI19K7E/hzzjVumjc=;
        b=Q+erHnrj8ufCARi33x5wefWy5BAIkLTYkAJW63cH5QgyPec7QC6e3AgbXGQjo7qXz4
         Wi1fxOzJCcc+RsWehVKOGND+bS7Env2bdNegAtoDR6EqMlx0QwYIwAZNd3Z36nX3RZrM
         xRbOJ/FzoaSJdKfrz8ttxqIMINQXW3z2LAazHJxmFvZwh/J9Xg95bGf58aod1Swaunu+
         YLCyVKGMal9eJoDJEwsYqJfzhAdUfF/DRhFM8nWmpha4VZiwDG6eB2KUDK8sA5oEvXsH
         zemet0vDjYLKKlfPyjwu9+qOFbHmWEfBiefR5XNPHcu7/CSZBJMmefE6lab/t7Hjl0Yn
         PnBQ==
X-Gm-Message-State: AOJu0YzBV22QjA81c+JF/LTT/a1OGpKC/7ccLNam6bjakumUpUxX6CMe
	JDqMyBsGnBZtXq1z7BvmcnXEEUTWmayQnH2X7CXhFKOIFtl9wNb97fWsyLhW3ivE
X-Gm-Gg: AeBDievOMoJbQx9A3Um1vA5mMIdKb5ExTZyrYs3Ojy9EHJnypjmyaeNvNEolNeYZBKQ
	tWQ7D10lpycBDvivtSZTIe7RXh711FNO8iSpUElWToEwKyZV2cbkYb+TNwrQqMRTt2KXGqFQfNI
	xeTk6dy4wvtPMmFLnX1GjVZkzNgD2E2rbazHlu0T49PSb6B5OWdnQLHLtI0xFEIE5FNnJhEkjRN
	f5hZqvy52g13joeJDvGOkH81C939knyBVNdjFad3S+/AzqzMdvhFoUwQtytxVzMEbvZHU7Bxwcl
	kFEbX+OI8tJaHOGthuhdpzArmsUsrMrbKYlyuazl+IRy2zvs4oLW1Kb3i9auNu+6l3JfzlIBxX2
	hlnE0ESBArjHktHBGG07vrcYc8LcTUaXjrKVMQzNdrZahGIb8EQj0V6wTuEyB+sHTjP0uz7P4lN
	vaYoD8eiMVM8NNGBaLoch94du9fBoLKESr/LhE7EvxHW5flWp5/QrwTGH+6odVurQ/EaQFhfYUm
	w==
X-Received: by 2002:a17:90b:384e:b0:35b:952c:43b9 with SMTP id 98e67ed59e1d1-3614040b2c7mr37984490a91.10.1777117686997;
        Sat, 25 Apr 2026 04:48:06 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm25653085a91.10.2026.04.25.04.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 04:48:06 -0700 (PDT)
Message-ID: <eefc176f8803ab1da8bbb0cae03d35d8d3df661a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	harishankar.vishwanathan@gmail.com
Date: Sat, 25 Apr 2026 04:48:03 -0700
In-Reply-To: <e0d8a24cbc3fd21cc361b93a3b25c9b412bc8c6a.camel@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
	 <e0d8a24cbc3fd21cc361b93a3b25c9b412bc8c6a.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-4a1WG0ERBVnF61IHd7KL"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-4a1WG0ERBVnF61IHd7KL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-04-25 at 03:05 -0700, Eduard Zingerman wrote:
> On Fri, 2026-04-24 at 15:52 -0700, Eduard Zingerman wrote:
> > This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
> > verifier by a pair of circular numbers (cnums): one for 64-bit domain
> > and another for 32-bit domain. Each cnum represents a range as a
> > single arc on the circular number line, from which signed and unsigned
> > bounds are derived on demand. See also wrapped intervals
> > representation as in [1].
> >=20
> > The use of such representation simplifies arithmetic and conditions
> > handling in verifier.c and allows to express 32 <-> 64 bit deductions
> > in a more mathematically rigorous way.
> >=20
> > [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
>=20
> Uh-oh. range_within() needs an update.
>=20
> [...]

The fix is as in the attachment, the tests are still passing, but the
stats had changed a bit. I'll send the fix formally later on Saturday.

Net increase:   98K insn 88 programs
Net decrease: -282K insn 52 programs

Raw stats filtered as -f insns_pct>1 -f !insns<10000:

=3D=3D=3D=3D=3D=3D=3D=3D=3D selftests: master vs experiment =3D=3D=3D=3D=3D=
=3D=3D=3D=3D

File  Program  Insns (A)  Insns (B)  Insns (DIFF)
----  -------  ---------  ---------  ------------

Total progs: 4665
Old success: 2924
New success: 2926
total_insns diff min:   -0.44%
total_insns diff max:   52.94%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 837,487
total_insns abs max new: 837,487
  -5 .. 0    %: 8
   0 .. 5    %: 4652
   5 .. 15   %: 1
  40 .. 50   %: 3
  50 .. 55   %: 1

=3D=3D=3D=3D=3D=3D=3D=3D=3D scx: master vs experiment =3D=3D=3D=3D=3D=3D=3D=
=3D=3D

File               Program          Insns (A)  Insns (B)  Insns     (DIFF)
-----------------  ---------------  ---------  ---------  ----------------
scx_layered.bpf.o  layered_enqueue      13718      14402     +684 (+4.99%)
scx_rusty.bpf.o    rusty_enqueue        39842      22053  -17789 (-44.65%)
scx_rusty.bpf.o    rusty_stopping       37738      19949  -17789 (-47.14%)
scx_wd40.bpf.o     wd40_stopping        37729      19880  -17849 (-47.31%)

Total progs: 376
Old success: 351
New success: 351
total_insns diff min:  -47.31%
total_insns diff max:   19.61%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 233,669
total_insns abs max new: 233,696
 -50 .. -40  %: 3
  -5 .. 0    %: 3
   0 .. 5    %: 367
   5 .. 15   %: 2
  15 .. 20   %: 1

=3D=3D=3D=3D=3D=3D=3D=3D=3D meta: master vs experiment =3D=3D=3D=3D=3D=3D=
=3D=3D=3D

File                                    Program              Insns (A)  Ins=
ns (B)  Insns     (DIFF)
--------------------------------------  -------------------  ---------  ---=
------  ----------------
<sandbox>                               test_file_open           88771     =
104160  +15389 (+17.34%)
<profiler>                              on_perf_event            48056     =
 54544   +6488 (+13.50%)
<profiler>                              on_tracepoint_event      48059     =
 54547   +6488 (+13.50%)
<profiler>                              on_perf_event            48056     =
 54544   +6488 (+13.50%)
<profiler>                              on_tracepoint_event      48059     =
 54547   +6488 (+13.50%)
<profiler>                              on_alloc                 50445     =
 56933   +6488 (+12.86%)
<profiler>                              on_free                  50251     =
 56739   +6488 (+12.91%)
<profiler>                              on_perf_event            48056     =
 54544   +6488 (+13.50%)
<profiler>                              on_tracepoint_event      48059     =
 54547   +6488 (+13.50%)
<profiler>                              future_iter_resume       50114     =
 56602   +6488 (+12.95%)
<profiler>                              on_py_event              50042     =
 56530   +6488 (+12.97%)
scx_layered_bpf_skel_genskel-bpf.bpf.o  layered_enqueue          13287     =
 13963     +676 (+5.09%)
scx_layered_bpf_skel_genskel-bpf.bpf.o  layered_enqueue          13269     =
 13945     +676 (+5.09%)
scx_layered_bpf_skel_genskel-bpf.bpf.o  layered_enqueue          13269     =
 13945     +676 (+5.09%)
<firewall>                              ..._egress              222327     =
164648  -57679 (-25.94%)
<firewall>                              ..._tc_eg               222839     =
164772  -58067 (-26.06%)
<firewall>                              ..._egress              222327     =
164648  -57679 (-25.94%)
<firewall>                              ..._tc_eg               222839     =
164772  -58067 (-26.06%)

Total progs: 1540
Old success: 1464
New success: 1464
total_insns diff min:  -26.06%
total_insns diff max:   37.25%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 666,036
total_insns abs max new: 666,036
 -30 .. -20  %: 4
  -5 .. 0    %: 10
   0 .. 5    %: 1494
   5 .. 10   %: 10
  10 .. 15   %: 13
  15 .. 25   %: 5
  35 .. 40   %: 4

=3D=3D=3D=3D=3D=3D=3D=3D=3D cilium: master vs experiment =3D=3D=3D=3D=3D=3D=
=3D=3D=3D

File             Program                            Insns (A)  Insns (B)  I=
nsns    (DIFF)
---------------  ---------------------------------  ---------  ---------  -=
--------------
bpf_host.o       tail_handle_ipv4_cont_from_host        20962      26024  +=
5062 (+24.15%)
bpf_host.o       tail_handle_ipv6_cont_from_host        17036      18672   =
+1636 (+9.60%)
bpf_host.o       tail_nodeport_nat_ingress_ipv4         20080      19858   =
 -222 (-1.11%)
bpf_lxc.o        tail_nodeport_nat_ingress_ipv4         10697      10510   =
 -187 (-1.75%)
bpf_overlay.o    tail_handle_inter_cluster_revsnat      11099      10857   =
 -242 (-2.18%)
bpf_overlay.o    tail_nodeport_nat_ingress_ipv4         11951      11768   =
 -183 (-1.53%)
bpf_wireguard.o  tail_nodeport_nat_ingress_ipv4         11993      11811   =
 -182 (-1.52%)

Total progs: 134
Old success: 134
New success: 134
total_insns diff min:   -3.32%
total_insns diff max:   24.15%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 152,012
total_insns abs max new: 152,012
  -5 .. 0    %: 12
   0 .. 5    %: 120
   5 .. 15   %: 1
  20 .. 25   %: 1

--=-4a1WG0ERBVnF61IHd7KL
Content-Disposition: attachment; filename="range-within-fix.patch"
Content-Type: text/x-patch; name="range-within-fix.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvY251bV9kZWZzLmggYi9rZXJuZWwvYnBmL2NudW1fZGVm
cy5oCmluZGV4IDNlYmQ4ZjcyM2RiYi4uYWYxZjEzYzU4OTAzIDEwMDY0NAotLS0gYS9rZXJuZWwv
YnBmL2NudW1fZGVmcy5oCisrKyBiL2tlcm5lbC9icGYvY251bV9kZWZzLmgKQEAgLTIyMCw2ICsy
MjAsMTcgQEAgYm9vbCBGTihpc19jb25zdCkoc3RydWN0IGNudW1fdCBjbnVtKQogCXJldHVybiBj
bnVtLnNpemUgPT0gMDsKIH0KIAorYm9vbCBGTihpc193aXRoaW4pKHN0cnVjdCBjbnVtX3Qgb3V0
ZXIsIHN0cnVjdCBjbnVtX3QgaW5uZXIpCit7CisgICAgICAgIGlmIChGTihpc19lbXB0eSkob3V0
ZXIpIHx8IEZOKGlzX2VtcHR5KGlubmVyKSkpCisJCXJldHVybiBmYWxzZTsKKwlpZiAob3V0ZXIu
c2l6ZSA9PSBVVF9NQVgpCisJCXJldHVybiB0cnVlOworCWlubmVyLmJhc2UgLT0gb3V0ZXIuYmFz
ZTsKKwlvdXRlci5iYXNlID0gMDsKKwlyZXR1cm4gIUZOKHVyYW5nZV9vdmVyZmxvdykoaW5uZXIp
ICYmIGlubmVyLmJhc2UgKyBpbm5lci5zaXplIDw9IG91dGVyLnNpemU7Cit9CisKICN1bmRlZiBF
TVBUWQogI3VuZGVmIGNudW1fdAogI3VuZGVmIHV0CmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL3N0
YXRlcy5jIGIva2VybmVsL2JwZi9zdGF0ZXMuYwppbmRleCBhNzhhZTg5MWI3NDMuLmUwNmMwNzk4
MTk0NSAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi9zdGF0ZXMuYworKysgYi9rZXJuZWwvYnBmL3N0
YXRlcy5jCkBAIC0xLDUgKzEsNiBAQAogLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seQogLyogQ29weXJpZ2h0IChjKSAyMDI2IE1ldGEgUGxhdGZvcm1zLCBJbmMuIGFuZCBh
ZmZpbGlhdGVzLiAqLworI2luY2x1ZGUgImxpbnV4L2NudW0uaCIKICNpbmNsdWRlIDxsaW51eC9i
cGYuaD4KICNpbmNsdWRlIDxsaW51eC9icGZfdmVyaWZpZXIuaD4KICNpbmNsdWRlIDxsaW51eC9m
aWx0ZXIuaD4KQEAgLTMwMSwxNCArMzAyLDggQEAgaW50IGJwZl91cGRhdGVfYnJhbmNoX2NvdW50
cyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3MKIHN0
YXRpYyBib29sIHJhbmdlX3dpdGhpbihjb25zdCBzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqb2xkLAog
CQkJIGNvbnN0IHN0cnVjdCBicGZfcmVnX3N0YXRlICpjdXIpCiB7Ci0JcmV0dXJuIHJlZ191bWlu
KG9sZCkgPD0gcmVnX3VtaW4oY3VyKSAmJgotCSAgICAgICByZWdfdW1heChvbGQpID49IHJlZ191
bWF4KGN1cikgJiYKLQkgICAgICAgcmVnX3NtaW4ob2xkKSA8PSByZWdfc21pbihjdXIpICYmCi0J
ICAgICAgIHJlZ19zbWF4KG9sZCkgPj0gcmVnX3NtYXgoY3VyKSAmJgotCSAgICAgICByZWdfdTMy
X21pbihvbGQpIDw9IHJlZ191MzJfbWluKGN1cikgJiYKLQkgICAgICAgcmVnX3UzMl9tYXgob2xk
KSA+PSByZWdfdTMyX21heChjdXIpICYmCi0JICAgICAgIHJlZ19zMzJfbWluKG9sZCkgPD0gcmVn
X3MzMl9taW4oY3VyKSAmJgotCSAgICAgICByZWdfczMyX21heChvbGQpID49IHJlZ19zMzJfbWF4
KGN1cik7CisJcmV0dXJuIGNudW02NF9pc193aXRoaW4ob2xkLT5yNjQsIGN1ci0+cjY0KSAmJgor
CSAgICAgICBjbnVtMzJfaXNfd2l0aGluKG9sZC0+cjMyLCBjdXItPnIzMik7CiB9CiAKIC8qIElm
IGluIHRoZSBvbGQgc3RhdGUgdHdvIHJlZ2lzdGVycyBoYWQgdGhlIHNhbWUgaWQsIHRoZW4gdGhl
eSBuZWVkIHRvIGhhdmUK


--=-4a1WG0ERBVnF61IHd7KL--
