Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2E2EAD15
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081365; cv=pass; b=EN9+ERg+gEIf30gFbg2XU+aKwPSvEpZt0DRqKEsuW4sAEMzQSPxi+jT+H6xSVcy4AGRkS20DsX/OETzkiQIf7FzhVio4MDscRX42Pl7n2nZDxftyUBXntFgAFloSzSb/OQfBbYZ04BkYd9ys0VxUTtxm3J4V2SfpZunziKJrou4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081365; c=relaxed/simple;
	bh=owkWPvRVlCFqAg2lzBAHQH8C7fGIMGG5Oc06xQ0GT9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ctLt/HMPAzbgHodvdDrbJCCCYBXCwkmegj4xgat9cyJVvgqim2851ojKs1AUVeNR+MteWEoShZyU/qwvAJOqxmvu+peHCHg8ginv/pYlY8RGEDph5EMhXyr9ZepRIdgg9iTfGH+ZTVj7fjFpcA6Ld1srlZK71pYOMPkQDRsh5AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vulnseeker.org; spf=pass smtp.mailfrom=vulnseeker.org; dkim=pass (2048-bit key) header.d=vulnseeker.org header.i=@vulnseeker.org header.b=uBpvw4CC; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vulnseeker.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vulnseeker.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vulnseeker.org header.i=@vulnseeker.org header.b="uBpvw4CC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845e363246aso500361b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 05:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081362; cv=none;
        d=google.com; s=arc-20260327;
        b=gW5ngtMlRdx1JW9FdlhRVcFbwPcmuEqoDyDfp6n5oUwOqlts0A9xr3J78X/mM469Tr
         qL+xYmUS1sArdHbX2kZEELdmI1g0qR9PaCguh+S7IV2c3lSgJ90tsohxiVSvEXQobyVg
         MBY8JsGM60kyXkDpX+x5EfXjnKPzwmFl2I2HjPLQ9bpHfYrKQ7O4ocdewZk3LM+1QFlL
         wkTL4+LxNNt/bgL3TOmhEqeNbOpE7hfoaMkfX09OB9v+JgNWH/I+/JJ01mbo4kKy+vOG
         8R10SuCc6bDnK3iPU8tKnjMv7DuqTRcl37RqNsTO8f5Nnl1r9rUCpgGpkrTY4Cq4owLC
         irrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XThSSMcGM1OVRZZG2GmYsZ+z6E5F2X2PojLLmXfRVMc=;
        fh=4obcCKWh/LVa5nN8uYYNSDZpJGxGUW8UlX6ahxblk34=;
        b=fBNzUrlkWkLJQcqIETZVLc5NM3qtWRRiyKCXC/H6p4G+L3sgexBDRR5eHnkiKZejHK
         sUBKgqLDIe4+LcQF5lD2m2oFg/bts9dnQwfCuea7EWnIpAVUTuCNV2mares/wyZgl4zw
         NBXFxOdwVY5Gkz1SltLdOsdYXWg5ubqM9NiXqw8gj/4sMBlVm3Kwrbeo4FN4NFv96zcP
         tyFKOttlYGe1kUEbIEA+tCkEhR6SrDt1rcp6PmDGa0GoLVKvHEw8aasBQG7tasSOzSwX
         k5PDVb1eQtMQ+qy3Zt7t1B81k1uIWMib4s2bxpk1DcNBKIYylltZExgWLiNjL7L9NION
         255A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vulnseeker.org; s=google; t=1783081362; x=1783686162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XThSSMcGM1OVRZZG2GmYsZ+z6E5F2X2PojLLmXfRVMc=;
        b=uBpvw4CCDzXSwdgzO4m31HCFtcMScmUkZbLpZCfFsb0U5qfUilmQ2wi72v00nOFscI
         YeE7D7mph/zLAVnZ0yroFcMImG6GgU/mP8zhVJL8qcYsvI01igMGQPQRDGN8b+KXGMzD
         MFcpqgegTbVMY1SVqVdlIpIYo5OGHticGn13JOypB/UQo1V+UfgxAPvBEdNCbYFwn+uJ
         lPTzl9UK1m6SbL6WE6VMCKd94oymANmBsRybXrT4ORIjLEJj2/Vbmp8wd7YPSEbqmzCa
         5UsXXrDJuWdhfxhBXF8602+FC6SOXHihwuM85pztc7oIOTVHWC3g4ozQ8ZFagaropXTG
         /dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081362; x=1783686162;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XThSSMcGM1OVRZZG2GmYsZ+z6E5F2X2PojLLmXfRVMc=;
        b=sO1GX3R3WxHVEXeN3A69f6ETBLqoR+csJs+em6zTWgyfyMaaEPueTvbF8H1CVf4MFm
         8grLWiDbslO2ZPlC+xwx+TmZY0QkpthdHNx3cBWzE0kjXpND/c3TMxdb5UdDOAuyUTUy
         kaswp1raPwsQ4K6D2OAPh/KYPIRhIessrJfncynhbkAY41KAz5JfaHYH1x4cMYcVk/sX
         i/N0H1WdibRsjeP/LmTQaTb1k4RI9yvEWZncf6l2S0Ojso5njVd8Tib0C/WzVAXnhFNa
         wRloJhRPZKXvAx8PMHvHwbGpfMAAP9SzNXlooMtAaiJi2CJlMqgPu8d9GeC0M4PQfqg+
         ea6A==
X-Gm-Message-State: AOJu0YwHMVNB5HvfEP3cBEWaVXsnxywlJP/9UzCX8tGjq/Z1rX/tF2UX
	U/AocnPrrGkp6O9G1lsuFAQPtTmDkiV+yzejqLWPP5gPPjyWuIVIwFhkjCmmz5IScKlDs4zmi0L
	vjinVgOx3f7HF8CRyMPX3JB4KbkWSYPmiPGsJHq29TIDWBTlwbk/r6DE4nQ==
X-Gm-Gg: AfdE7cm+E78xMmSSvigJa9O6rD/vFMvZgLlKgV84krNrBwqgIQh4chtXQYb9VQxtbfy
	JGJtMpO20o2ou/9c7k3QZT7utbmBo8kbqN7JSfykZTKYSqBoT62Fnv4BQKDEnjUTk5i2feYr2JV
	pPpE7acEbLiI3Fr4EOUNEubH+GH+WPwjGOF9T/3cx7/zZ1VuOfO0EqEzi390gmLwags6re8QaVZ
	XQ2NfN5PzxnzHIhJDb5emVwU32ANLYles8z6eEKn+JeUotiwCzC5U/T8lzCgQr+/wgSSH9Z
X-Received: by 2002:a05:6a00:2d98:b0:845:d274:bf9d with SMTP id
 d2e1a72fcca58-847c08d217fmr10178520b3a.52.1783081362032; Fri, 03 Jul 2026
 05:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vuln seeker Cyber Security Team <security@vulnseeker.org>
Date: Fri, 3 Jul 2026 17:22:30 +0500
X-Gm-Features: AVVi8CeMRBO_ttk82C4m2XZ8WHCzBvz5WQYzOWkihUQZJdwxRLpaJZvqdUu-lqc
Message-ID: <CAO_sQLjn=hghkb7SZr2UWexf=opgLTu5_AHR2uTQrJ1r13vpjg@mail.gmail.com>
Subject: Responsible Disclosure: Heap Out-of-Bounds Write via Integer
 Underflow in libbpf parse_cpu_mask_str() (libbpf.c:14446)
To: bpf@vger.kernel.org
Cc: security@vulnseeker.org
Content-Type: multipart/mixed; boundary="00000000000030ed9c0655b3fbcd"

--00000000000030ed9c0655b3fbcd
Content-Type: multipart/alternative; boundary="00000000000030ed9b0655b3fbcb"

--00000000000030ed9b0655b3fbcb
Content-Type: text/plain; charset="UTF-8"

Dear libbpf Security Team,

I am responsibly disclosing a heap out-of-bounds write vulnerability in
libbpf's CPU mask parser. An integer underflow in parse_cpu_mask_str()
causes a memset to write far past a shrunk heap allocation, reachable
end-to-end through the public libbpf_num_possible_cpus() API.

*VULNERABILITY SUMMARY*

parse_cpu_mask_str() in src/libbpf.c validates each parsed CPU range with:

  if (start < 0 || start > end)
      return -EINVAL;

but never checks start against the running *mask_sz. When an out-of-order
or overlapping range is encountered (e.g. "2-3,0-1"), the second iteration
causes realloc(*mask, end+1) to shrink the buffer, after which:

  memset(tmp + *mask_sz, 0, start - *mask_sz)   // libbpf.c:14446

computes start - *mask_sz as a negative int (e.g. 0 - 4 = -4), which
converts to a huge size_t. The memset then writes far past the shrunk
allocation, producing a heap out-of-bounds write.

Two inputs have been confirmed:
  - "2-3,0-1": start - *mask_sz = 0 - 4 = -4 -> negative-size-param
(size=-4)
  - "5,0":     start - *mask_sz = 0 - 6 = -6 -> negative-size-param
(size=-6)

*AFFECTED COMPONENT*

  Repository : https://github.com/libbpf/libbpf
  Commit     : caa25e0b72746fef7ea01497ece7db57187f132c (HEAD validated)
  File       : src/libbpf.c
  Function   : parse_cpu_mask_str() (line 14446)

*CWE CLASSIFICATION*

  Primary    : CWE-191 (Integer Underflow)
  Resultant  : CWE-122 (Heap-based Buffer Overflow)
  Resultant  : CWE-787 (Out-of-bounds Write)

*CALL CHAIN (end-to-end via public API)*

  libbpf_num_possible_cpus()    (libbpf.c:14500  -- LIBBPF_API, exported in
libbpf.map)
    parse_cpu_mask_file("/sys/devices/system/cpu/possible")
 (libbpf.c:14486)
      parse_cpu_mask_str(<file bytes>)
 (libbpf.c:14412)
        memset(tmp + *mask_sz, 0, start - *mask_sz)  OOB
(libbpf.c:14446)

The vulnerability is reached through a documented, exported public symbol
-- not an internal helper. Any libbpf consumer that calls
libbpf_num_possible_cpus() is exposed whenever the bytes at
/sys/devices/system/cpu/possible are malformed or out of order.

*REACHABILITY*

On stock Linux the kernel always writes ascending CPU ranges to
/sys/devices/system/cpu/possible, so the default host sysfs path is safe.
The realistic exposure is:

  - A host or container where that sysfs path is attacker-influenced
(custom or overlay sysfs, crafted mount namespace, or a non-Linux/emulated
CPU-mask source)
  - Any downstream consumer that feeds untrusted CPU-mask strings to the
internal parse_cpu_mask_str helper directly

This is why the CVSS score is conservative (Medium). The crash is genuine
on the shipping public API, not just an internal code path.

*REPRODUCTION*

Prerequisites:
  - clang with AddressSanitizer, libelf-dev, zlib1g-dev, unshare
(util-linux)

Steps:
  1. Clone and build libbpf with ASan:
       git clone https://github.com/libbpf/libbpf.git repo
       cd repo && git checkout caa25e0b72746fef7ea01497ece7db57187f132c
       # Build all .c files with -fsanitize=address and link libbpf.so

  2. Build the e2e harness (calls ONLY the public
libbpf_num_possible_cpus()):
       clang -O1 -g -fsanitize=address -I<incl> e2e.c -Wl,-rpath,.
libbpf.so -o e2e

  3. Bind-mount the crafted possible-cpus file and invoke the public API:
       unshare -m -r sh -c \
         "mount --bind poc-possible-cpus.txt
/sys/devices/system/cpu/possible; \
          ASAN_OPTIONS=abort_on_error=0:exitcode=99 ./e2e"

*Expected output (UNPATCHED):*

  ERROR: AddressSanitizer: negative-size-param: (size=-4)
      #0 in __asan_memset
      #1 in parse_cpu_mask_str    src/libbpf.c:14446
      #2 in parse_cpu_mask_file   src/libbpf.c:14486
      #3 in libbpf_num_possible_cpus  src/libbpf.c:14500
      #4 in main
  0x... is located 2 bytes after 2-byte region [...)
  allocated by thread T0 in parse_cpu_mask_str src/libbpf.c:14440 (realloc)

Valid input "0-31" returns libbpf_num_possible_cpus() = 32 cleanly with no
ASan output.

Full build and run instructions, including the bind-mount technique and
patch verification steps, are provided in the attached REPRODUCE.md.

*SEVERITY ASSESSMENT*

  CVSS 4.0 Vector : AV:L/AC:H/PR:L/UI:N/S:U/C:N/I:L/A:L
  CVSS 4.0 Score  : 4.0 (Medium)
  CWE             : CWE-122/787 via CWE-191

Scored Medium due to the high attack complexity (attacker must influence
the sysfs path content) and the local attack vector. The integrity and
availability impact is low to moderate: the OOB write corrupts adjacent
heap memory, which can lead to process crash or heap metadata corruption in
sanitized and production builds respectively.

Note: this finding is distinct from CVE-2025-29481 (bpf_object__init_prog);
no existing GHSA or fix commit addresses parse_cpu_mask_str.

*SUGGESTED FIX*

Add a check in parse_cpu_mask_str() to reject a new sub-range whose start
falls below the current *mask_sz, preventing the shrink-then-underflow
sequence:

  if (start < *mask_sz)
      return -EINVAL;  // "CPU range out of order or overlapping"

A verified patch (fix.diff, approximately 5 lines) is attached. It has been
tested against three scenarios:
  - "2-3,0-1": returns -22, log message "CPU range out of order or
overlapping", no crash
  - "5,0":     returns -22, no crash
  - "0-31":    libbpf_num_possible_cpus() = 32, no regression

*ATTACHED ARTIFACTS*

  report.md              Detailed technical assessment
  fix.diff               Unified diff patch (verified at HEAD caa25e0b)
  asan-trace-e2e.txt     ASan trace from the public API e2e harness
  asan-trace.txt         ASan trace from the direct parse_cpu_mask_str
harness
  poc-possible-cpus.txt  Crafted /sys/devices/system/cpu/possible input
("2-3,0-1")
  poc-cpumask.txt        Direct function-level input (same content)
  REPRODUCE.md           Step-by-step reproduction walkthrough

We discovered this issue via static analysis and validated it end-to-end on
2026-06-25 against HEAD commit caa25e0b, with a QA re-validation on a clean
box confirming both the crash and the patch on the same day. We are sharing
this report in accordance with responsible disclosure practices and are
happy to coordinate on a remediation timeline with the libbpf maintainers.

Please do not hesitate to reach out if you require additional information,
a different proof-of-concept format, or clarification on any part of this
report.

Reporter: Yevgen Goncharuk <yevgen@vulnseeker.org>.
Signed-off-by: Yevgen Goncharuk <yevgen@vulnseeker.org>
Author: Yevgen Goncharuk

Best Regards,
Yevgen Goncharuk

--00000000000030ed9b0655b3fbcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Dear libbpf Security Team,<br><br>I am re=
sponsibly disclosing a heap out-of-bounds write vulnerability in libbpf&#39=
;s CPU mask parser. An integer underflow in parse_cpu_mask_str() causes a m=
emset to write far past a shrunk heap allocation, reachable end-to-end thro=
ugh the public libbpf_num_possible_cpus() API.<br><br><b>VULNERABILITY SUMM=
ARY</b><br><br>parse_cpu_mask_str() in src/libbpf.c validates each parsed C=
PU range with:<br><br>=C2=A0 if (start &lt; 0 || start &gt; end)<br>=C2=A0 =
=C2=A0 =C2=A0 return -EINVAL;<br><br>but never checks start against the run=
ning *mask_sz. When an out-of-order or overlapping range is encountered (e.=
g. &quot;2-3,0-1&quot;), the second iteration causes realloc(*mask, end+1) =
to shrink the buffer, after which:<br><br>=C2=A0 memset(tmp + *mask_sz, 0, =
start - *mask_sz) =C2=A0 // libbpf.c:14446<br><br>computes start - *mask_sz=
 as a negative int (e.g. 0 - 4 =3D -4), which converts to a huge size_t. Th=
e memset then writes far past the shrunk allocation, producing a heap out-o=
f-bounds write.<br><br>Two inputs have been confirmed:<br>=C2=A0 - &quot;2-=
3,0-1&quot;: start - *mask_sz =3D 0 - 4 =3D -4 -&gt; negative-size-param (s=
ize=3D-4)<br>=C2=A0 - &quot;5,0&quot;: =C2=A0 =C2=A0 start - *mask_sz =3D 0=
 - 6 =3D -6 -&gt; negative-size-param (size=3D-6)<br><br><b>AFFECTED COMPON=
ENT</b><br><br>=C2=A0 Repository :<span class=3D"gmail-Apple-converted-spac=
e">=C2=A0</span><a href=3D"https://github.com/libbpf/libbpf" target=3D"_bla=
nk">https://github.com/libbpf/libbpf</a><br>=C2=A0 Commit =C2=A0 =C2=A0 : c=
aa25e0b72746fef7ea01497ece7db57187f132c (HEAD validated)<br>=C2=A0 File =C2=
=A0 =C2=A0 =C2=A0 : src/libbpf.c<br>=C2=A0 Function =C2=A0 : parse_cpu_mask=
_str() (line 14446)<br><br><b>CWE CLASSIFICATION</b><br><br>=C2=A0 Primary =
=C2=A0 =C2=A0: CWE-191 (Integer Underflow)<br>=C2=A0 Resultant =C2=A0: CWE-=
122 (Heap-based Buffer Overflow)<br>=C2=A0 Resultant =C2=A0: CWE-787 (Out-o=
f-bounds Write)<br><br><b>CALL CHAIN (end-to-end via public API)</b><br><br=
>=C2=A0 libbpf_num_possible_cpus() =C2=A0 =C2=A0(libbpf.c:14500 =C2=A0-- LI=
BBPF_API, exported in libbpf.map)<br>=C2=A0 =C2=A0 parse_cpu_mask_file(&quo=
t;/sys/devices/system/cpu/possible&quot;) =C2=A0(libbpf.c:14486)<br>=C2=A0 =
=C2=A0 =C2=A0 parse_cpu_mask_str(&lt;file bytes&gt;) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(libbpf.c:144=
12)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(tmp + *mask_sz, 0, start - *mask_=
sz) =C2=A0OOB =C2=A0 =C2=A0 (libbpf.c:14446)<br><br>The vulnerability is re=
ached through a documented, exported public symbol -- not an internal helpe=
r. Any libbpf consumer that calls libbpf_num_possible_cpus() is exposed whe=
never the bytes at /sys/devices/system/cpu/possible are malformed or out of=
 order.<br><br><b>REACHABILITY</b><br><br>On stock Linux the kernel always =
writes ascending CPU ranges to /sys/devices/system/cpu/possible, so the def=
ault host sysfs path is safe. The realistic exposure is:<br><br>=C2=A0 - A =
host or container where that sysfs path is attacker-influenced (custom or o=
verlay sysfs, crafted mount namespace, or a non-Linux/emulated CPU-mask sou=
rce)<br>=C2=A0 - Any downstream consumer that feeds untrusted CPU-mask stri=
ngs to the internal parse_cpu_mask_str helper directly<br><br>This is why t=
he CVSS score is conservative (Medium). The crash is genuine on the shippin=
g public API, not just an internal code path.<br><br><b>REPRODUCTION</b><br=
><br>Prerequisites:<br>=C2=A0 - clang with AddressSanitizer, libelf-dev, zl=
ib1g-dev, unshare (util-linux)<br><br>Steps:<br>=C2=A0 1. Clone and build l=
ibbpf with ASan:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0git clone<span class=3D"gmai=
l-Apple-converted-space">=C2=A0</span><a href=3D"https://github.com/libbpf/=
libbpf.git" target=3D"_blank">https://github.com/libbpf/libbpf.git</a><span=
 class=3D"gmail-Apple-converted-space">=C2=A0</span>repo<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0cd repo &amp;&amp; git checkout caa25e0b72746fef7ea01497ece7db=
57187f132c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0# Build all .c files with -fsaniti=
ze=3Daddress and link libbpf.so<br><br>=C2=A0 2. Build the e2e harness (cal=
ls ONLY the public libbpf_num_possible_cpus()):<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0clang -O1 -g -fsanitize=3Daddress -I&lt;incl&gt; e2e.c -Wl,-rpath,. libb=
pf.so -o e2e<br><br>=C2=A0 3. Bind-mount the crafted possible-cpus file and=
 invoke the public API:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0unshare -m -r sh -c \=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;mount --bind poc-possible-cpus.=
txt /sys/devices/system/cpu/possible; \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ASAN_OPTIONS=3Dabort_on_error=3D0:exitcode=3D99 ./e2e&quot;<br><br><b>E=
xpected output (UNPATCHED):</b><br><br>=C2=A0 ERROR: AddressSanitizer: nega=
tive-size-param: (size=3D-4)<br>=C2=A0 =C2=A0 =C2=A0 #0 in __asan_memset<br=
>=C2=A0 =C2=A0 =C2=A0 #1 in parse_cpu_mask_str =C2=A0 =C2=A0src/libbpf.c:14=
446<br>=C2=A0 =C2=A0 =C2=A0 #2 in parse_cpu_mask_file =C2=A0 src/libbpf.c:1=
4486<br>=C2=A0 =C2=A0 =C2=A0 #3 in libbpf_num_possible_cpus =C2=A0src/libbp=
f.c:14500<br>=C2=A0 =C2=A0 =C2=A0 #4 in main<br>=C2=A0 0x... is located 2 b=
ytes after 2-byte region [...)<br>=C2=A0 allocated by thread T0 in parse_cp=
u_mask_str src/libbpf.c:14440 (realloc)<br><br>Valid input &quot;0-31&quot;=
 returns libbpf_num_possible_cpus() =3D 32 cleanly with no ASan output.<br>=
<br>Full build and run instructions, including the bind-mount technique and=
 patch verification steps, are provided in the attached REPRODUCE.md.<br><b=
r><b>SEVERITY ASSESSMENT</b><br><br>=C2=A0 CVSS 4.0 Vector : AV:L/AC:H/PR:L=
/UI:N/S:U/C:N/I:L/A:L<br>=C2=A0 CVSS 4.0 Score =C2=A0: 4.0 (Medium)<br>=C2=
=A0 CWE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : CWE-122/787 via CWE-191=
<br><br>Scored Medium due to the high attack complexity (attacker must infl=
uence the sysfs path content) and the local attack vector. The integrity an=
d availability impact is low to moderate: the OOB write corrupts adjacent h=
eap memory, which can lead to process crash or heap metadata corruption in =
sanitized and production builds respectively.<br><br>Note: this finding is =
distinct from CVE-2025-29481 (bpf_object__init_prog); no existing GHSA or f=
ix commit addresses parse_cpu_mask_str.<br><br><b>SUGGESTED FIX</b><br><br>=
Add a check in parse_cpu_mask_str() to reject a new sub-range whose start f=
alls below the current *mask_sz, preventing the shrink-then-underflow seque=
nce:<br><br>=C2=A0 if (start &lt; *mask_sz)<br>=C2=A0 =C2=A0 =C2=A0 return =
-EINVAL; =C2=A0// &quot;CPU range out of order or overlapping&quot;<br><br>=
A verified patch (fix.diff, approximately 5 lines) is attached. It has been=
 tested against three scenarios:<br>=C2=A0 - &quot;2-3,0-1&quot;: returns -=
22, log message &quot;CPU range out of order or overlapping&quot;, no crash=
<br>=C2=A0 - &quot;5,0&quot;: =C2=A0 =C2=A0 returns -22, no crash<br>=C2=A0=
 - &quot;0-31&quot;: =C2=A0 =C2=A0libbpf_num_possible_cpus() =3D 32, no reg=
ression<br><br><b>ATTACHED ARTIFACTS</b><br><br>=C2=A0 report.md =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Detailed technical assessment<br>=C2=
=A0 fix.diff =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Unified diff =
patch (verified at HEAD caa25e0b)<br>=C2=A0 asan-trace-e2e.txt =C2=A0 =C2=
=A0 ASan trace from the public API e2e harness<br>=C2=A0 asan-trace.txt =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ASan trace from the direct parse_cpu_mask_str harn=
ess<br>=C2=A0 poc-possible-cpus.txt =C2=A0Crafted /sys/devices/system/cpu/p=
ossible input (&quot;2-3,0-1&quot;)<br>=C2=A0 poc-cpumask.txt =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Direct function-level input (same content)<br>=C2=A0 REPRODUC=
E.md =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Step-by-step reproduction walkthrou=
gh<br><br>We discovered this issue via static analysis and validated it end=
-to-end on 2026-06-25 against HEAD commit caa25e0b, with a QA re-validation=
 on a clean box confirming both the crash and the patch on the same day. We=
 are sharing this report in accordance with responsible disclosure practice=
s and are happy to coordinate on a remediation timeline with the libbpf mai=
ntainers.<br><br>Please do not hesitate to reach out if you require additio=
nal information, a different proof-of-concept format, or clarification on a=
ny part of this report.<br><br>Reporter: Yevgen Goncharuk &lt;<a href=3D"ma=
ilto:yevgen@vulnseeker.org" target=3D"_blank">yevgen@vulnseeker.org</a>&gt;=
.<br>Signed-off-by: Yevgen Goncharuk &lt;<a href=3D"mailto:yevgen@vulnseeke=
r.org" target=3D"_blank">yevgen@vulnseeker.org</a>&gt;</div><div dir=3D"ltr=
">Author:=C2=A0Yevgen Goncharuk</div><div dir=3D"ltr"><br></div><div dir=3D=
"ltr">Best Regards,<br>Yevgen Goncharuk</div></div>

--00000000000030ed9b0655b3fbcb--
--00000000000030ed9c0655b3fbcd
Content-Type: text/plain; charset="UTF-8"; name="asan-trace-e2e.txt"
Content-Disposition: attachment; filename="asan-trace-e2e.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxmm0>
X-Attachment-Id: f_mr4whxmm0

IyBFMkUgdHJhY2Ug4oCUIGNyYXNoIHJlYWNoZWQgdGhyb3VnaCB0aGUgUFVCTElDIGxpYmJwZiBB
UEkgbGliYnBmX251bV9wb3NzaWJsZV9jcHVzKCkKIyAobm90IHRoZSBpbnRlcm5hbCBwYXJzZV9j
cHVfbWFza19zdHIpLiBUaGUgbWFsZm9ybWVkIENQVS1tYXNrIGRhdGEgZW50ZXJzIHZpYSB0aGUK
IyByZWFsIGZpbGUtcmVhZCBwYXRoIHBhcnNlX2NwdV9tYXNrX2ZpbGUoKSByZWFkaW5nIC9zeXMv
ZGV2aWNlcy9zeXN0ZW0vY3B1L3Bvc3NpYmxlLgojIEEgY3JhZnRlZCBwb3NzaWJsZS1jcHVzIGZp
bGUgKCIyLTMsMC0xIikgd2FzIGJpbmQtbW91bnRlZCBvdmVyIHRoYXQgc3lzZnMgcGF0aCBpbiBh
bgojIHVuc2hhcmVkIG1vdW50IG5hbWVzcGFjZTsgdGhlIGUyZSBoYXJuZXNzIGNhbGxzIE9OTFkg
bGliYnBmX251bV9wb3NzaWJsZV9jcHVzKCkuCgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo9PVBJRD09RVJST1I6IEFkZHJl
c3NTYW5pdGl6ZXI6IG5lZ2F0aXZlLXNpemUtcGFyYW06IChzaXplPS00KQogICAgIzAgPGFkZHI+
IGluIF9fYXNhbl9tZW1zZXQgKDxzY3JhdGNoPi9lMmUrMHhjYTA5YykKICAgICMxIDxhZGRyPiBp
biBwYXJzZV9jcHVfbWFza19zdHIgICAgPHNjcmF0Y2g+L3JlcG8vc3JjL2xpYmJwZi5jOjE0NDQ2
OjMKICAgICMyIDxhZGRyPiBpbiBwYXJzZV9jcHVfbWFza19maWxlICAgPHNjcmF0Y2g+L3JlcG8v
c3JjL2xpYmJwZi5jOjE0NDg2OjkKICAgICMzIDxhZGRyPiBpbiBsaWJicGZfbnVtX3Bvc3NpYmxl
X2NwdXMgPHNjcmF0Y2g+L3JlcG8vc3JjL2xpYmJwZi5jOjE0NTAwOjgKICAgICM0IDxhZGRyPiBp
biBtYWluICAgICAgICAgICAgICAgICAgPHNjcmF0Y2g+L2UyZS5jOjQ6MTMKICAgICM1IDxhZGRy
PiBpbiBfX2xpYmNfc3RhcnRfbWFpbiBsaWJjLnNvLjYKICAgICM2IDxhZGRyPiBpbiBfc3RhcnQg
KDxzY3JhdGNoPi9lMmUrMHgyYzM2MCkKCjB4NTAyMDAwMDAwMDM0IGlzIGxvY2F0ZWQgMiBieXRl
cyBhZnRlciAyLWJ5dGUgcmVnaW9uIFsweDUwMjAwMDAwMDAzMCwweDUwMjAwMDAwMDAzMikKYWxs
b2NhdGVkIGJ5IHRocmVhZCBUMCBoZXJlOgogICAgIzAgPGFkZHI+IGluIHJlYWxsb2MgKDxzY3Jh
dGNoPi9lMmUrMHhjYzViMCkKICAgICMxIDxhZGRyPiBpbiBwYXJzZV9jcHVfbWFza19zdHIgICAg
PHNjcmF0Y2g+L3JlcG8vc3JjL2xpYmJwZi5jOjE0NDQwOjkKICAgICMyIDxhZGRyPiBpbiBwYXJz
ZV9jcHVfbWFza19maWxlICAgPHNjcmF0Y2g+L3JlcG8vc3JjL2xpYmJwZi5jOjE0NDg2OjkKICAg
ICMzIDxhZGRyPiBpbiBsaWJicGZfbnVtX3Bvc3NpYmxlX2NwdXMgPHNjcmF0Y2g+L3JlcG8vc3Jj
L2xpYmJwZi5jOjE0NTAwOjgKICAgICM0IDxhZGRyPiBpbiBtYWluICAgICAgICAgICAgICAgICAg
PHNjcmF0Y2g+L2UyZS5jOjQ6MTMKClNVTU1BUlk6IEFkZHJlc3NTYW5pdGl6ZXI6IG5lZ2F0aXZl
LXNpemUtcGFyYW0gKDxzY3JhdGNoPi9lMmUpIGluIF9fYXNhbl9tZW1zZXQKPT1QSUQ9PUFCT1JU
SU5HCgojIENhcHR1cmVkIGF0IGxpYmJwZiBIRUFEIGNhYTI1ZTBiNzI3NDZmZWY3ZWEwMTQ5N2Vj
ZTdkYjU3MTg3ZjEzMmMuCiMgT09CIG1lbXNldCBzaW5rOiBzcmMvbGliYnBmLmM6MTQ0NDYgIG1l
bXNldCh0bXAgKyAqbWFza19zeiwgMCwgc3RhcnQgLSAqbWFza19zeikKIyBzaHJ1bmsgcmVhbGxv
YyByZWdpb246IHNyYy9saWJicGYuYzoxNDQ0MCAgcmVhbGxvYygqbWFzaywgZW5kICsgMSkKIyBQ
dWJsaWMgZW50cnk6IGxpYmJwZl9udW1fcG9zc2libGVfY3B1cygpIChMSUJCUEZfQVBJLCBleHBv
cnRlZCBpbiBsaWJicGYubWFwKS4KIyBTZWNvbmQgZTJlIGlucHV0ICI1LDAiIC0+IG5lZ2F0aXZl
LXNpemUtcGFyYW0gKHNpemU9LTYpIGF0IHRoZSBzYW1lIHNpbmssIHNhbWUgc3RhY2suCiMKIyBQ
YXRjaCAoZml4LmRpZmYpIHJlLXZlcmlmaWVkIG9uIHRoZSBTQU1FIGUyZSBoYXJuZXNzOgojICAg
Y3JhZnRlZCAiMi0zLDAtMSIgLT4gbGliYnBmOiAiQ1BVIHJhbmdlIG91dCBvZiBvcmRlciBvciBv
dmVybGFwcGluZyIgLT4gcmV0dXJucyAtMjIsIG5vIEFTYW4gY3Jhc2gKIyAgIHZhbGlkICAgIjAt
MzEiICAgIC0+IGxpYmJwZl9udW1fcG9zc2libGVfY3B1cygpID0gMzIgKGNsZWFuKQo=
--00000000000030ed9c0655b3fbcd
Content-Type: text/plain; charset="US-ASCII"; name="asan-trace.txt"
Content-Disposition: attachment; filename="asan-trace.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxmu1>
X-Attachment-Id: f_mr4whxmu1

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPT1QSUQ9PUVSUk9SOiBBZGRyZXNzU2FuaXRpemVyOiBuZWdhdGl2ZS1zaXplLXBh
cmFtOiAoc2l6ZT0tNCkKICAgICMwIDxhZGRyPiBpbiBfX2FzYW5fbWVtc2V0ICg8c2NyYXRjaD4v
cG9jKzB4ZjA0M2MpCiAgICAjMSA8YWRkcj4gaW4gcGFyc2VfY3B1X21hc2tfc3RyIDxzY3JhdGNo
Pi9yZXBvL3NyYy9saWJicGYuYzoxNDQ0NjozCiAgICAjMiA8YWRkcj4gaW4gbWFpbiA8c2NyYXRj
aD4vaGFybmVzcy5jOjEyOjE1CiAgICAjMyA8YWRkcj4gaW4gX19saWJjX3N0YXJ0X2NhbGxfbWFp
biBjc3UvLi4vc3lzZGVwcy9ucHRsL2xpYmNfc3RhcnRfY2FsbF9tYWluLmg6NTg6MTYKICAgICM0
IDxhZGRyPiBpbiBfX2xpYmNfc3RhcnRfbWFpbiBjc3UvLi4vY3N1L2xpYmMtc3RhcnQuYzozNjA6
MwogICAgIzUgPGFkZHI+IGluIF9zdGFydCAoPHNjcmF0Y2g+L3BvYysweDUyNzAwKQoKMHg1MDIw
MDAwMDAwMzQgaXMgbG9jYXRlZCAyIGJ5dGVzIGFmdGVyIDItYnl0ZSByZWdpb24gWzB4NTAyMDAw
MDAwMDMwLDB4NTAyMDAwMDAwMDMyKQphbGxvY2F0ZWQgYnkgdGhyZWFkIFQwIGhlcmU6CiAgICAj
MCA8YWRkcj4gaW4gcmVhbGxvYyAoPHNjcmF0Y2g+L3BvYysweGYyOTUwKQogICAgIzEgPGFkZHI+
IGluIHBhcnNlX2NwdV9tYXNrX3N0ciA8c2NyYXRjaD4vcmVwby9zcmMvbGliYnBmLmM6MTQ0NDA6
OQogICAgIzIgPGFkZHI+IGluIG1haW4gPHNjcmF0Y2g+L2hhcm5lc3MuYzoxMjoxNQogICAgIzMg
PGFkZHI+IGluIF9fbGliY19zdGFydF9jYWxsX21haW4gY3N1Ly4uL3N5c2RlcHMvbnB0bC9saWJj
X3N0YXJ0X2NhbGxfbWFpbi5oOjU4OjE2CgpTVU1NQVJZOiBBZGRyZXNzU2FuaXRpemVyOiBuZWdh
dGl2ZS1zaXplLXBhcmFtICg8c2NyYXRjaD4vcG9jKSBpbiBfX2FzYW5fbWVtc2V0Cj09UElEPT1B
Qk9SVElORwoKIyBUcmFjZSBjYXB0dXJlZCBhdCBsaWJicGYgSEVBRCBjYWEyNWUwYjcyNzQ2ZmVm
N2VhMDE0OTdlY2U3ZGI1NzE4N2YxMzJjLgojIG1lbXNldCBPT0Igd3JpdGUgaXMgYXQgc3JjL2xp
YmJwZi5jOjE0NDQ2IChtZW1zZXQodG1wICsgKm1hc2tfc3osIDAsIHN0YXJ0IC0gKm1hc2tfc3op
KTsKIyB0aGUgc2hydW5rIHJlYWxsb2MgcmVnaW9uIGlzIGFsbG9jYXRlZCBhdCBzcmMvbGliYnBm
LmM6MTQ0NDAgKHJlYWxsb2MoKm1hc2ssIGVuZCArIDEpKS4KIyBSZXByb2R1Y2VkIGJ5IGxpbmtp
bmcgdGhlIHJlYWwgcGFyc2VfY3B1X21hc2tfc3RyIGZyb20gYSBmdWxsIEFTYW4gYnVpbGQgb2Yg
bGliYnBmCiMgKGNsYW5nIC1PMSAtZnNhbml0aXplPWFkZHJlc3MpIGFnYWluc3QgYSAzLWxpbmUg
aGFybmVzczsgaW5wdXQgIjItMywwLTEiLgojIFNlY29uZCBQb0MgaW5wdXQgIjUsMCIgeWllbGRz
IHNpemU9LTYgYXQgdGhlIHNhbWUgc2luay4K
--00000000000030ed9c0655b3fbcd
Content-Type: application/octet-stream; name="fix.diff"
Content-Disposition: attachment; filename="fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxn02>
X-Attachment-Id: f_mr4whxn02

ZGlmZiAtLWdpdCBhL3NyYy9saWJicGYuYyBiL3NyYy9saWJicGYuYwppbmRleCBhYjIwNzFmLi43
YWI4OTMyIDEwMDY0NAotLS0gYS9zcmMvbGliYnBmLmMKKysrIGIvc3JjL2xpYmJwZi5jCkBAIC0x
NDQzNyw2ICsxNDQzNywxMSBAQCBpbnQgcGFyc2VfY3B1X21hc2tfc3RyKGNvbnN0IGNoYXIgKnMs
IGJvb2wgKiptYXNrLCBpbnQgKm1hc2tfc3opCiAJCQllcnIgPSAtRUlOVkFMOwogCQkJZ290byBj
bGVhbnVwOwogCQl9CisJCWlmIChzdGFydCA8ICptYXNrX3N6KSB7CisJCQlwcl93YXJuKCJDUFUg
cmFuZ2Ugb3V0IG9mIG9yZGVyIG9yIG92ZXJsYXBwaW5nIGluICVzXG4iLCBzKTsKKwkJCWVyciA9
IC1FSU5WQUw7CisJCQlnb3RvIGNsZWFudXA7CisJCX0KIAkJdG1wID0gcmVhbGxvYygqbWFzaywg
ZW5kICsgMSk7CiAJCWlmICghdG1wKSB7CiAJCQllcnIgPSAtRU5PTUVNOwo=
--00000000000030ed9c0655b3fbcd
Content-Type: text/plain; charset="US-ASCII"; name="poc-cpumask.txt"
Content-Disposition: attachment; filename="poc-cpumask.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxn43>
X-Attachment-Id: f_mr4whxn43

Mi0zLDAtMQo=
--00000000000030ed9c0655b3fbcd
Content-Type: text/plain; charset="US-ASCII"; name="poc-possible-cpus.txt"
Content-Disposition: attachment; filename="poc-possible-cpus.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxn84>
X-Attachment-Id: f_mr4whxn84

Mi0zLDAtMQo=
--00000000000030ed9c0655b3fbcd
Content-Type: text/markdown; charset="UTF-8"; name="REPORTING.md"
Content-Disposition: attachment; filename="REPORTING.md"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxne6>
X-Attachment-Id: f_mr4whxne6

IyBSZXBvcnRpbmcgY2hhbm5lbCDigJQgbGliYnBmCgotICoqQ2hhbm5lbCBjbGFzczoqKiBLZXJu
ZWwgc2VjdXJpdHkgdGVhbSBlbWFpbCAocHJpdmF0ZSkg4oCUIGtlcm5lbCBDTkEKLSAqKlBWUjoq
KiBPRkYg4oCUIG5vIEdpdEh1YiBTZWN1cml0eSBBZHZpc29yeSByb3V0ZS4KLSAqKlByaW1hcnkg
Y29udGFjdDoqKiBgc2VjdXJpdHlAa2VybmVsLm9yZ2Ag4oCUIGNhbm9uaWNhbCwgYmVjYXVzZSBs
aWJicGYncyBhdXRob3JpdGF0aXZlIHNvdXJjZSBpcyBgdG9vbHMvbGliL2JwZmAgaW4gdGhlIGtl
cm5lbCBicGYtbmV4dCB0cmVlIGFuZCBDVkVzIGFyZSBpc3N1ZWQgYnkgdGhlIGtlcm5lbCBDTkEu
CiAgLSBNYWludGFpbmVyOiBBbmRyaWkgTmFrcnlpa28gYGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5j
b21gCiAgLSBUZWNobmljYWwgbGlzdCBgYnBmQHZnZXIua2VybmVsLm9yZ2AgaXMgcHVibGljIOKA
lCBOT1QgZm9yIGVtYmFyZ29lZCByZXBvcnRzLgotICoqQWx0ZXJuYXRpdmUgKGZvciB0aGUgc3Rh
bmRhbG9uZS91c2Vyc3BhY2UgcGFyc2luZyBzdXJmYWNlIE9TUy1GdXp6IGV4ZXJjaXNlcyk6Kiog
ZmlsZSB2aWEgdGhlIE9TUy1GdXp6IGlzc3VlIHRyYWNrZXIgKDkwLWRheSBlbWJhcmdvKS4KLSAq
Kkdvb2dsZSBQYXRjaC1SZXdhcmRzIGVsaWdpYmxlOioqIOKchSB5ZXMgKE9TUy1GdXp6LWludGVn
cmF0ZWQpLgoKUmVwb3J0ZXI6IFlldmdlbiBHb25jaGFydWsgPHlldmdlbkB2dWxuc2Vla2VyLm9y
Zz4uIE5vdGhpbmcgdHJhbnNtaXR0ZWQgYnkgdG9vbGluZyDigJQgdXNlciBzZW5kcy4K
--00000000000030ed9c0655b3fbcd
Content-Type: text/markdown; charset="UTF-8"; name="report.md"
Content-Disposition: attachment; filename="report.md"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxnb5>
X-Attachment-Id: f_mr4whxnb5

IyBsaWJicGYgQCBjYWEyNWUwYjcyNzQ2ZmVmN2VhMDE0OTdlY2U3ZGI1NzE4N2YxMzJjIChzcmMv
bGliYnBmLmM6MTQ0NDYsIHBhcnNlX2NwdV9tYXNrX3N0cikKCnwgRmllbGQgfCBWYWx1ZSB8Cnwt
LS18LS0tfAp8IFZlcmRpY3QgfCBjb25maXJtZWQtcG9jLWUyZSAocmVhbCBwdWJsaWMgQVBJIGVu
dHJ5IHBvaW50KSB8CnwgQ1ZTUyB8IDQuMCBNZWRpdW0gQVY6TC9BQzpIL1BSOkwvVUk6Ti9TOlUv
QzpOL0k6TC9BOkwgfAp8IFBhdGNoIHwgYnVpbGQtdmVyaWZpZWQgKyBlMmUtdmVyaWZpZWQgKHJl
YnVpbHQgYXQgSEVBRDogYmxvY2tzIGJvdGggY3Jhc2ggaW5wdXRzIHRocm91Z2ggdGhlIHB1Ymxp
YyBBUEksIHZhbGlkIGlucHV0cyBwcmVzZXJ2ZWQpIHwKfCBEZWR1cCB8IG5vdmVsIHwKfCBDaGFu
bmVsIHwgR2l0SHViIFByaXZhdGUgVnVsbmVyYWJpbGl0eSBSZXBvcnRpbmcgb24gbGliYnBmL2xp
YmJwZjsgbWFpbnRhaW5lciBhbmRyaWkubmFrcnlpa29AZ21haWwuY29tLiBPU1MtRnV6ei1pbnRl
Z3JhdGVkIC0+IGxhbmRlZCBwYXRjaCBHb29nbGUgUGF0Y2gtUmV3YXJkcyBlbGlnaWJsZS4gfAoK
IyMgUG9DCmBgYApFMkUgdmlhIFBVQkxJQyBBUEk6IEFkZHJlc3NTYW5pdGl6ZXI6IG5lZ2F0aXZl
LXNpemUtcGFyYW0gKHNpemU9LTQpIGluIF9fYXNhbl9tZW1zZXQKICA8LSBwYXJzZV9jcHVfbWFz
a19zdHIgICBzcmMvbGliYnBmLmM6MTQ0NDYKICA8LSBwYXJzZV9jcHVfbWFza19maWxlICBzcmMv
bGliYnBmLmM6MTQ0ODYKICA8LSBsaWJicGZfbnVtX3Bvc3NpYmxlX2NwdXMgIHNyYy9saWJicGYu
YzoxNDUwMCAgIChMSUJCUEZfQVBJLCBleHBvcnRlZCkKICA8LSBtYWluCldyaXRlIDIgYnl0ZXMg
YWZ0ZXIgMi1ieXRlIHJlYWxsb2MoZW5kKzEpIHJlZ2lvbi4gVGhlIG1hbGZvcm1lZCBDUFUgbWFz
ayBlbnRlcnMKdGhyb3VnaCB0aGUgcmVhbCBmaWxlIHBhdGg6IGxpYmJwZl9udW1fcG9zc2libGVf
Y3B1cygpIHJlYWRzCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Bvc3NpYmxlLiBQb0MgYmluZC1t
b3VudHMgYSBjcmFmdGVkIHBvc3NpYmxlLWNwdXMgZmlsZQooIjItMywwLTEiKSBvdmVyIHRoYXQg
c3lzZnMgcGF0aCBpbiBhbiB1bnNoYXJlZCBtb3VudCBuYW1lc3BhY2UgYW5kIGNhbGxzIG9ubHkg
dGhlCnB1YmxpYyBsaWJicGZfbnVtX3Bvc3NpYmxlX2NwdXMoKSBsaW5rZWQgYWdhaW5zdCB0aGUg
UkVBTCBsaWJicGYuc28gKGNsYW5nIC1PMQotZnNhbml0aXplPWFkZHJlc3MsIGFsbCAyMSAuYyBm
aWxlcykuIFNlY29uZCBpbnB1dCAiNSwwIiAtPiBzaXplPS02LCBzYW1lIHN0YWNrLgpWYWxpZCAi
MC0zMSIgLT4gcmV0dXJucyAzMjsgIjAtMyIvIjAtMSwyLTMiIHBhcnNlIGNsZWFubHkuIFJlcHJv
ZHVjZWQgYXQgSEVBRApjYWEyNWUwYi4gKEEgZnVuY3Rpb24tbGV2ZWwgaGFybmVzcyBjYWxsaW5n
IHBhcnNlX2NwdV9tYXNrX3N0ciBkaXJlY3RseSBhbHNvCnJlcHJvZHVjZXMg4oCUIHNlZSBwb2Mt
Y3B1bWFzay50eHQg4oCUIGJ1dCB0aGUgZTJlIFBvQyBhYm92ZSBoaXRzIHRoZSBzaGlwcGluZyBw
dWJsaWMKZW50cnkgcG9pbnQsIG5vdCB0aGUgaW50ZXJuYWwgaGVscGVyLikKYGBgCgojIyBOb3Rl
cwpIZWFwIE9PQiB3cml0ZSBpbiBwYXJzZV9jcHVfbWFza19zdHI6IG9ubHkgY2hlY2tzIHN0YXJ0
PmVuZCwgbmV2ZXIgc3RhcnQgdnMgcnVubmluZyAqbWFza19zei4gT3V0LW9mLW9yZGVyL292ZXJs
YXBwaW5nIHJhbmdlIHNocmlua3MgYnVmZmVyIHZpYSByZWFsbG9jKGVuZCsxKSB0aGVuIG1lbXNl
dCh0bXArKm1hc2tfc3osIDAsIHN0YXJ0LSptYXNrX3N6KSB1bmRlcmZsb3dzIGludCAoMC00KSAt
PiBzaXplX3QgaHVnZSBjb3VudCBwYXN0IHNocnVuayBhbGxvYy4gQ1dFLTEyMi83ODcgdmlhIENX
RS0xOTEuIFZFUkRJQ1QgY29uZmlybWVkLXBvYy1lMmU6IHRoZSBjcmFzaCBub3cgcmVwcm9kdWNl
cyB0aHJvdWdoIHRoZSBTSElQUElORyBQVUJMSUMgQVBJIGxpYmJwZl9udW1fcG9zc2libGVfY3B1
cygpIChMSUJCUEZfQVBJLCBleHBvcnRlZCBpbiBsaWJicGYubWFwKSByZWFkaW5nIC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L3Bvc3NpYmxlIHZpYSBwYXJzZV9jcHVfbWFza19maWxlIC0+IHBhcnNl
X2NwdV9tYXNrX3N0ci4gVGhlIGUyZSBoYXJuZXNzIGxpbmtzIHRoZSByZWFsIGxpYmJwZi5zbyBh
bmQgcmVmZXJlbmNlcyBPTkxZIHRoZSBwdWJsaWMgc3ltYm9sOyBhIGNyYWZ0ZWQgcG9zc2libGUt
Y3B1cyBmaWxlIGlzIGJpbmQtbW91bnRlZCBvdmVyIHRoZSBzeXNmcyBwYXRoIGluIGFuIHVuc2hh
cmVkIG1vdW50IG5hbWVzcGFjZS4gQVNhbiBuZWdhdGl2ZS1zaXplLXBhcmFtIChzaXplPS00IGZv
ciAiMi0zLDAtMSIsIHNpemU9LTYgZm9yICI1LDAiKSBhdCBzcmMvbGliYnBmLmM6MTQ0NDYuIFJl
YWNoYWJpbGl0eSBudWFuY2UgKGtlZXBzIGl0IE1lZGl1bSk6IG9uIHN0b2NrIExpbnV4IHRoZSBr
ZXJuZWwgYWx3YXlzIHdyaXRlcyBhc2NlbmRpbmcgcmFuZ2VzIHRvIHRoYXQgc3lzZnMgZmlsZSwg
c28gdGhlIGRlZmF1bHQgaG9zdCBwcm9kdWNlciBpcyB0cnVzdGVkOyByZWFsaXN0aWMgZXhwb3N1
cmUgaXMgYSBob3N0L2NvbnRhaW5lciB3aGVyZSB0aGF0IGZpbGUgaXMgYXR0YWNrZXItaW5mbHVl
bmNlZCwgb3IgYSBkb3duc3RyZWFtIGNvbnN1bWVyIGZlZWRpbmcgdW50cnVzdGVkIENQVS1tYXNr
IHN0cmluZ3MgdG8gdGhlIGhlbHBlcnMuIFBhdGNoIChmaXguZGlmZiwgNSBsaW5lczogcmVqZWN0
IHN0YXJ0PCptYXNrX3N6KSBnaXQtYXBwbHktY2hlY2tzIE9LLCBhbmQgcmUtdmVyaWZpZWQgb24g
dGhlIGUyZSBoYXJuZXNzOiBibG9ja3MgYm90aCBjcmFzaCBpbnB1dHMgKHJldHVybnMgLTIyLCAi
Q1BVIHJhbmdlIG91dCBvZiBvcmRlciBvciBvdmVybGFwcGluZyIpIGFuZCBwcmVzZXJ2ZXMgdmFs
aWQgaW5wdXQgKDAtMzEgLT4gMzIpLiBQYWNrZXQgY29udGFpbnM6IHJlcG9ydC5tZCwgZml4LmRp
ZmYsIFJFUFJPRFVDRS5tZCwgUkVBRElORVNTLm1kLCBhc2FuLXRyYWNlLnR4dCwgYXNhbi10cmFj
ZS1lMmUudHh0LCBwb2MtY3B1bWFzay50eHQsIHBvYy1wb3NzaWJsZS1jcHVzLnR4dC4gQm94IHNj
cmF0Y2ggY2xlYW5lZCwgbm8gaW50ZXJuYWxzIGxlYWtlZC4gQ29kZVFMIG5vdGUgd2FzIGNwcC9t
aXNzaW5nLWNoZWNrLXNjYW5mIChiZW5pZ24gaGVyZSkgLS0gcmlnaHQgZnVuY3Rpb24sIHdyb25n
IHJlYXNvbjsgcmVhbCBidWcgaXMgdGhlIHN0YXJ0LSptYXNrX3N6IHVuZGVyZmxvdy4KCiMjIERl
ZHVwCkRpc3RpbmN0IGZyb20gQ1ZFLTIwMjUtMjk0ODEgKGJwZl9vYmplY3RfX2luaXRfcHJvZyku
IE5vIEdIU0EvY29tbWl0IGZvciBwYXJzZV9jcHVfbWFza19zdHI7IHNpbmsgdW5jaGFuZ2VkIGlu
IGN1cnJlbnQgbWFzdGVyIGxpbmUgMTQ0NDYuCgpSZXBvcnRlcjogWWV2Z2VuIEdvbmNoYXJ1ayA8
eWV2Z2VuQHZ1bG5zZWVrZXIub3JnPi4gVmFsaWRhdGVkIDIwMjYtMDYtMjU7IFFBIHJlLXZhbGlk
YXRlZCBvbiBhIGNsZWFuIGJveCBhdCBIRUFEIDIwMjYtMDYtMjUgKGNyYXNoICsgcGF0Y2ggYm90
aCByZS1jb25maXJtZWQpLgo=
--00000000000030ed9c0655b3fbcd
Content-Type: text/markdown; charset="UTF-8"; name="REPRODUCE.md"
Content-Disposition: attachment; filename="REPRODUCE.md"
Content-Transfer-Encoding: base64
Content-ID: <f_mr4whxni7>
X-Attachment-Id: f_mr4whxni7

IyBSRVBST0RVQ0Ug4oCUIGxpYmJwZiBwYXJzZV9jcHVfbWFza19zdHIgaGVhcCBPT0Igd3JpdGUK
ClRhcmdldDogbGliYnBmIEAgY2FhMjVlMGI3Mjc0NmZlZjdlYTAxNDk3ZWNlN2RiNTcxODdmMTMy
YwpTaW5rOiBgc3JjL2xpYmJwZi5jOjE0NDQ2YCDigJQgYG1lbXNldCh0bXAgKyAqbWFza19zeiwg
MCwgc3RhcnQgLSAqbWFza19zeilgCkJ1ZyBjbGFzczogQ1dFLTc4NyAvIENXRS0xMjIgaGVhcCBv
dXQtb2YtYm91bmRzIHdyaXRlIHZpYSBDV0UtMTkxIGludCB1bmRlcmZsb3cuCgojIyBNZWNoYW5p
c20KYHBhcnNlX2NwdV9tYXNrX3N0cmAgdmFsaWRhdGVzIG9ubHkgYHN0YXJ0IDwgMCB8fCBzdGFy
dCA+IGVuZGAuIEl0IG5ldmVyIGNoZWNrcwpgc3RhcnRgIGFnYWluc3QgdGhlIHJ1bm5pbmcgYCpt
YXNrX3N6YC4gQW4gb3V0LW9mLW9yZGVyIC8gb3ZlcmxhcHBpbmcgQ1BVIHJhbmdlCihlLmcuIGEg
bGF0ZXIgc3ViLXJhbmdlIHdpdGggYSBzbWFsbGVyIGVuZCB0aGFuIGFuIGVhcmxpZXIgb25lKSBj
YXVzZXMKYHJlYWxsb2MoKm1hc2ssIGVuZCArIDEpYCB0byBTSFJJTksgdGhlIGJ1ZmZlciwgYWZ0
ZXIgd2hpY2gKYG1lbXNldCh0bXAgKyAqbWFza19zeiwgMCwgc3RhcnQgLSAqbWFza19zeilgIGNv
bXB1dGVzIGEgbmVnYXRpdmUgYGludGAKKGBzdGFydCAtICptYXNrX3N6YCkgdGhhdCBjb252ZXJ0
cyB0byBhIGh1Z2UgYHNpemVfdGAsIHdyaXRpbmcgZmFyIHBhc3QgdGhlCnNocnVuayBhbGxvY2F0
aW9uLgoKLSBJbnB1dCBgIjItMywwLTEiYDogaXRlcjEgc3RhcnQ9MixlbmQ9MyAtPiByZWFsbG9j
IDQgYnl0ZXMsIG1hc2tfc3o9NDsKICBpdGVyMiBzdGFydD0wLGVuZD0xIC0+IHJlYWxsb2MgMiBi
eXRlcyAoc2hyaW5rKSwgYHN0YXJ0LSptYXNrX3N6ID0gMC00ID0gLTRgCiAgLT4gQVNhbiBgbmVn
YXRpdmUtc2l6ZS1wYXJhbSAoc2l6ZT0tNClgLgotIElucHV0IGAiNSwwImA6IGAwLTYgPSAtNmAg
LT4gYG5lZ2F0aXZlLXNpemUtcGFyYW0gKHNpemU9LTYpYC4KCiMjIENvbmZpcm1lZCBlbmQtdG8t
ZW5kOiB0aGUgY3Jhc2ggaXMgZHJpdmVuIHRocm91Z2ggdGhlIFBVQkxJQyBsaWJicGYgQVBJCgpU
aGUgT09CIGlzIHJlYWNoZWQgd2l0aG91dCB0b3VjaGluZyBhbnkgaW50ZXJuYWwgc3ltYm9sLiBg
bGliYnBmX251bV9wb3NzaWJsZV9jcHVzKClgCmlzIGEgYExJQkJQRl9BUElgIHB1YmxpYyBmdW5j
dGlvbiAoZXhwb3J0ZWQgaW4gYHNyYy9saWJicGYubWFwYCkuIEl0IGNhbGxzCmBwYXJzZV9jcHVf
bWFza19maWxlKCIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9wb3NzaWJsZSIsIC4uLilgLCB3aGlj
aCBgcmVhZCgyKWBzIHRoZQpmaWxlIGFuZCBoYW5kcyB0aGUgYnl0ZXMgdG8gYHBhcnNlX2NwdV9t
YXNrX3N0cmAuIEEgbWFsZm9ybWVkIHBvc3NpYmxlLWNwdXMgZmlsZQpjb250ZW50IHJlYWNoZXMg
dGhlIHZ1bG5lcmFibGUgYG1lbXNldGA6CgpgYGAKbWFpbgogLT4gbGliYnBmX251bV9wb3NzaWJs
ZV9jcHVzKCkgICAgICAgICAgW1BVQkxJQywgbGliYnBmLmM6MTQ0ODldCiAtPiBwYXJzZV9jcHVf
bWFza19maWxlKCIvc3lzLy4uLi9jcHUvcG9zc2libGUiKSAgW2xpYmJwZi5jOjE0NTAwLzE0NDg2
XQogLT4gcGFyc2VfY3B1X21hc2tfc3RyKDxmaWxlIGJ5dGVzPikgICAgIFtsaWJicGYuYzoxNDQx
Ml0KIC0+IG1lbXNldCh0bXAgKyAqbWFza19zeiwgMCwgc3RhcnQgLSAqbWFza19zeikgIE9PQiAg
W2xpYmJwZi5jOjE0NDQ2XQpgYGAKCiMjIyBCdWlsZCArIHJ1biAoY29weS1wYXN0ZSwgZTJlKQpS
ZXF1aXJlcyBjbGFuZyB3aXRoIEFTYW4sIGxpYmVsZi1kZXYsIHpsaWIxZy1kZXYsIGdpdCwgYW5k
IGB1bnNoYXJlYCAodXRpbC1saW51eCkuCgpgYGBzaApTQ1JBVENIPSQobWt0ZW1wIC1kKQpjZCAi
JFNDUkFUQ0giCmdpdCBjbG9uZSBodHRwczovL2dpdGh1Yi5jb20vbGliYnBmL2xpYmJwZi5naXQg
cmVwbwpjZCByZXBvCmdpdCBjaGVja291dCBjYWEyNWUwYjcyNzQ2ZmVmN2VhMDE0OTdlY2U3ZGI1
NzE4N2YxMzJjICAgIyBvciBjdXJyZW50IEhFQUQKCiMgQnVpbGQgZXZlcnkgbGliYnBmIC5jIHdp
dGggQVNhbiAoLWZQSUMgZm9yIHRoZSBzaGFyZWQgbGlicmFyeSkKY2Qgc3JjCmZvciBmIGluICou
YzsgZG8KICBjbGFuZyAtTzEgLWcgLWZzYW5pdGl6ZT1hZGRyZXNzIC1mbm8tb21pdC1mcmFtZS1w
b2ludGVyIC1mUElDIC1EX0dOVV9TT1VSQ0UgXAogICAgLUkuIC1JLi4vaW5jbHVkZSAtSS4uL2lu
Y2x1ZGUvdWFwaSAtYyAiJGYiIC1vICIkU0NSQVRDSC9vYmpfJHtmJS5jfS5vIgpkb25lCgojIExp
bmsgdGhlIFJFQUwgbGliYnBmIHNoYXJlZCBvYmplY3QgKGV4cG9ydHMgbGliYnBmX251bV9wb3Nz
aWJsZV9jcHVzKQpjbGFuZyAtc2hhcmVkIC1mc2FuaXRpemU9YWRkcmVzcyAtbyAiJFNDUkFUQ0gv
bGliYnBmLnNvIiAiJFNDUkFUQ0giL29ial8qLm8gLWxlbGYgLWx6Cm5tIC1EICIkU0NSQVRDSC9s
aWJicGYuc28iIHwgZ3JlcCBsaWJicGZfbnVtX3Bvc3NpYmxlX2NwdXMgICAjIGV4cG9ydGVkIHB1
YmxpYyBzeW1ib2wKCiMgUHVibGljLWhlYWRlciBpbmNsdWRlIHRyZWUgZm9yIDxicGYvbGliYnBm
Lmg+Cm1rZGlyIC1wICIkU0NSQVRDSC9pbmNsL2JwZiI7IGNwICIkU0NSQVRDSC9yZXBvL3NyYy8i
Ki5oICIkU0NSQVRDSC9pbmNsL2JwZi8iCgojIEUyRSBoYXJuZXNzOiBjYWxscyBPTkxZIHRoZSBw
dWJsaWMgQVBJIOKAlCBubyBpbnRlcm5hbCBzeW1ib2wgcmVmZXJlbmNlcwpjYXQgPiAiJFNDUkFU
Q0gvZTJlLmMiIDw8J0VPRicKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxicGYvbGliYnBm
Lmg+CmludCBtYWluKHZvaWQpIHsKICAgIGludCBuID0gbGliYnBmX251bV9wb3NzaWJsZV9jcHVz
KCk7CiAgICBwcmludGYoImxpYmJwZl9udW1fcG9zc2libGVfY3B1cygpID0gJWRcbiIsIG4pOwog
ICAgcmV0dXJuIDA7Cn0KRU9GCmNsYW5nIC1PMSAtZyAtZnNhbml0aXplPWFkZHJlc3MgLUkiJFND
UkFUQ0gvaW5jbCIgIiRTQ1JBVENIL2UyZS5jIiBcCiAgICAtV2wsLXJwYXRoLCIkU0NSQVRDSCIg
IiRTQ1JBVENIL2xpYmJwZi5zbyIgLW8gIiRTQ1JBVENIL2UyZSIKCiMgQ3JhZnRlZCBtYWxmb3Jt
ZWQgcG9zc2libGUtY3B1cyBmaWxlcyAocmVhbCBwcm9kdWN0IGlucHV0KQpwcmludGYgIjItMyww
LTFcbiIgPiAiJFNDUkFUQ0gvZmFrZV9wb3NzaWJsZSIgICAgICMgb3V0LW9mLW9yZGVyIHJhbmdl
ICAtPiBzaXplPS00CnByaW50ZiAiNSwwXG4iICAgICA+ICIkU0NSQVRDSC9mYWtlX3Bvc3NpYmxl
MiIgICAgICMgLT4gc2l6ZT0tNgpwcmludGYgIjAtMzFcbiIgICAgPiAiJFNDUkFUQ0gvdmFsaWRf
cG9zc2libGUiICAgICAjIHZhbGlkIC0+IDMyIGNwdXMKCiMgRHJpdmUgdGhlIFJFQUwgcGF0aDog
YmluZC1tb3VudCB0aGUgY3JhZnRlZCBmaWxlIG92ZXIgc3lzZnMgaW4gYSBwcml2YXRlIG1vdW50
IG5zLAojIHRoZW4gY2FsbCB0aGUgcHVibGljIEFQSS4gKHVuc2hhcmUgLXIgbWFwcyB0byByb290
IGluc2lkZSB0aGUgdXNlcittb3VudCBucy4pCnJ1bigpIHsgdW5zaGFyZSAtbSAtciBzaCAtYyAi
bW91bnQgLS1iaW5kIFwiJDFcIiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9wb3NzaWJsZTsgXAog
ICAgICAgIEFTQU5fT1BUSU9OUz1hYm9ydF9vbl9lcnJvcj0wOmV4aXRjb2RlPTk5IFwiJFNDUkFU
Q0gvZTJlXCIiOyBlY2hvICJleGl0PSQ/IjsgfQoKcnVuICIkU0NSQVRDSC9mYWtlX3Bvc3NpYmxl
IiAgICAgIyBBZGRyZXNzU2FuaXRpemVyOiBuZWdhdGl2ZS1zaXplLXBhcmFtIChzaXplPS00KSwg
ZXhpdD05OQpydW4gIiRTQ1JBVENIL2Zha2VfcG9zc2libGUyIiAgICAjIG5lZ2F0aXZlLXNpemUt
cGFyYW0gKHNpemU9LTYpLCBleGl0PTk5CnJ1biAiJFNDUkFUQ0gvdmFsaWRfcG9zc2libGUiICAg
ICMgbGliYnBmX251bV9wb3NzaWJsZV9jcHVzKCkgPSAzMiwgZXhpdD0wCmBgYAoKT2JzZXJ2ZWQg
QVNhbiBzdGFjayAoc2VlIGBhc2FuLXRyYWNlLWUyZS50eHRgKToKYF9fYXNhbl9tZW1zZXQgPC0g
cGFyc2VfY3B1X21hc2tfc3RyOjE0NDQ2IDwtIHBhcnNlX2NwdV9tYXNrX2ZpbGU6MTQ0ODYgPC0g
bGliYnBmX251bV9wb3NzaWJsZV9jcHVzOjE0NTAwIDwtIG1haW5gLgoKVGhlIFBvQyBpbnB1dCBm
aWxlIGBwb2MtcG9zc2libGUtY3B1cy50eHRgIGNvbnRhaW5zIGAyLTMsMC0xYCAocGxhY2UgaXQg
YXQKYC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Bvc3NpYmxlYCwgZS5nLiB2aWEgdGhlIGJpbmQt
bW91bnQgYWJvdmUpLiBUaGUgb3JpZ2luYWwKZGlyZWN0LWNhbGwgaW5wdXQgZmlsZSBgcG9jLWNw
dW1hc2sudHh0YCAoYWxzbyBgMi0zLDAtMWApIHJlbWFpbnMgZm9yIHRoZQpmdW5jdGlvbi1sZXZl
bCBoYXJuZXNzLgoKIyMgUGF0Y2ggdmVyaWZpY2F0aW9uIChyZS1ydW4gYWdhaW5zdCB0aGUgZTJl
IGhhcm5lc3MpCmBgYHNoCmNkICIkU0NSQVRDSC9yZXBvIgpnaXQgYXBwbHkgLS1jaGVjayAvcGF0
aC90by9maXguZGlmZiAgICMgYXBwbGllcyBjbGVhbiBhdCBIRUFECmdpdCBhcHBseSAvcGF0aC90
by9maXguZGlmZgojIHJlYnVpbGQgbGliYnBmLmMsIHJlbGluayBsaWJicGYuc28sIHJlLXJ1biB0
aGUgU0FNRSBlMmUgaGFybmVzczoKY2Qgc3JjCmNsYW5nIC1PMSAtZyAtZnNhbml0aXplPWFkZHJl
c3MgLWZuby1vbWl0LWZyYW1lLXBvaW50ZXIgLWZQSUMgLURfR05VX1NPVVJDRSBcCiAgLUkuIC1J
Li4vaW5jbHVkZSAtSS4uL2luY2x1ZGUvdWFwaSAtYyBsaWJicGYuYyAtbyAiJFNDUkFUQ0gvb2Jq
X2xpYmJwZi5vIgpjbGFuZyAtc2hhcmVkIC1mc2FuaXRpemU9YWRkcmVzcyAtbyAiJFNDUkFUQ0gv
bGliYnBmLnNvIiAiJFNDUkFUQ0giL29ial8qLm8gLWxlbGYgLWx6CiMgICBydW4gZmFrZV9wb3Nz
aWJsZSAgKCIyLTMsMC0xIikgLT4gbGliYnBmOiAiQ1BVIHJhbmdlIG91dCBvZiBvcmRlciBvciBv
dmVybGFwcGluZyIgLT4gcmV0dXJucyAtMjIsIG5vIGNyYXNoLCBleGl0PTAKIyAgIHJ1biBmYWtl
X3Bvc3NpYmxlMiAoIjUsMCIpICAgICAtPiByZXR1cm5zIC0yMiwgbm8gY3Jhc2gsIGV4aXQ9MAoj
ICAgcnVuIHZhbGlkX3Bvc3NpYmxlICgiMC0zMSIpICAgIC0+IGxpYmJwZl9udW1fcG9zc2libGVf
Y3B1cygpID0gMzIsIGV4aXQ9MApgYGAKQ29uZmlybWVkOiBwYXRjaCBibG9ja3MgYm90aCBlMmUg
Y3Jhc2ggaW5wdXRzIHRocm91Z2ggdGhlIHB1YmxpYyBBUEkgYW5kIHByZXNlcnZlcwp2YWxpZCBp
bnB1dCBwYXJzaW5nLgoKIyMgUmVhY2hhYmlsaXR5IG5vdGUgKHVwZGF0ZWQg4oCUIGUyZSB2aWEg
cHVibGljIEFQSSkKYGxpYmJwZl9udW1fcG9zc2libGVfY3B1cygpYCBpcyBhIFBVQkxJQywgZXhw
b3J0ZWQgQVBJIChgTElCQlBGX0FQSWAsIHByZXNlbnQgaW4KYHNyYy9saWJicGYubWFwYCkuIEl0
IHJlYWRzIGAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9wb3NzaWJsZWAgYW5kIHBhcnNlcyBpdHMK
Y29udGVudHMgdGhyb3VnaCBgcGFyc2VfY3B1X21hc2tfZmlsZWAgLT4gYHBhcnNlX2NwdV9tYXNr
X3N0cmAuIFRoZSBPT0Igd3JpdGUgaXMKdGhlcmVmb3JlIHJlYWNoYWJsZSBlbmQtdG8tZW5kIGZy
b20gYSBub3JtYWwgbGliYnBmIGNvbnN1bWVyIHdoZW5ldmVyIHRoZSBieXRlcyBhdAp0aGF0IHN5
c2ZzIHBhdGggYXJlIG1hbGZvcm1lZC9vdXQtb2Ytb3JkZXIuIE9uIHN0b2NrIExpbnV4IHRoZSBr
ZXJuZWwgYWx3YXlzIGVtaXRzCmFzY2VuZGluZyByYW5nZXMgdGhlcmUsIHNvIHRoZSBkZWZhdWx0
IGhvc3QgcGF0aCBpcyBzYWZlOyB0aGUgcmVhbGlzdGljIGV4cG9zdXJlIGlzCihhKSBhIGhvc3Qv
Y29udGFpbmVyIHdoZXJlIHRoYXQgZmlsZSBpcyBhdHRhY2tlci1pbmZsdWVuY2VkIChjdXN0b20v
b3ZlcmxheSBzeXNmcywKY3JhZnRlZCBtb3VudCwgb3IgYSBub24tTGludXgvZW11bGF0ZWQgY3B1
LW1hc2sgc291cmNlKSwgb3IgKGIpIGFueSBkb3duc3RyZWFtCmNvbnN1bWVyIHRoYXQgZmVlZHMg
dW50cnVzdGVkIENQVS1tYXNrIHN0cmluZ3MgdG8gdGhlIGludGVybmFsIGhlbHBlcnMuIFRoZSBj
cmFzaAppcyBnZW51aW5lIG9uIHRoZSBTSElQUElORyBwdWJsaWMgQVBJLCBub3QganVzdCB0aGUg
aW50ZXJuYWwgaGVscGVyLiBTY29yZWQgTWVkaXVtCihDVlNTIDQuMCwgQVY6TC9BQzpIL1BSOkwv
VUk6Ti9TOlUvQzpOL0k6TC9BOkwpIGJlY2F1c2UgdGhlIGRlZmF1bHQgc3lzZnMgcHJvZHVjZXIK
aXMgdHJ1c3RlZDsgdGhlIGUyZSBQb0MgZGVtb25zdHJhdGVzIHRoZSBzaW5rIGlzIHJlYWNoYWJs
ZSB0aHJvdWdoIHRoZSBwdWJsaWMgZW50cnkKcG9pbnQgZ2l2ZW4gbWFsZm9ybWVkIGlucHV0IGF0
IHRoYXQgcGF0aC4K
--00000000000030ed9c0655b3fbcd--
