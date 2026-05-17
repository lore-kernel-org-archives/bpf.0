Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D11405C22
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999019; cv=pass; b=BfGrLunn+8KAR6G/itfzDwDHRDTSXAUMu9qqegyb1Lr5R2P4e9VALQ3tjzdJzm1gcHq2PWU99gOGPQ4QP49/qqvHbvoeVz1TAJE4487fKz889V8v1xgJZ3jDuEndHNCZ6XSKi9jLPVuk3bfI/ILpZu7Oi9vsWsgFVpDTmcYmJsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999019; c=relaxed/simple;
	bh=Rcs8gOk50fJLZVF8W7GAMzLQV1AotsVK0Pxiloo0OPk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vi6e5Wh7QWpD7Fstis8WVkxSWVS+7fETxIwVvVsi2Qh/TPKxhXHviIascupqwqzkx98VsCZ0+fImjBCf5x8lOtK3QyGSx/hJn0P+1f8zFBV+/2JmUFfcZnVULvhl4JmySKxqM8nEJkbzg6q8IdEDbkgxP85jRs1KB7Ct4HkeLcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMF+8f8h; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMF+8f8h"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-434e69e943bso1066546fac.3
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778999016; cv=none;
        d=google.com; s=arc-20240605;
        b=e8BMsAw+wsJSdp0D4Uo5LQGz9/T2XuYKXxtt00+LID3VYmhgQPqhvDcCejipOgkPOM
         gILGv24gWOUQgRnNXBKpS7rREoG8w2kNkSXOejsLGou3TGhLQBN3WAN4ISjKvgB++ZK+
         72NgTraNem7abPYsR4C9c5gLZBkOWf3sL/Hl9PS33RsLhi6H/Xz/h6W5cOkXKCqDuAxj
         t/QdBofrAO7HRROynb2yj3nJ2ofSdFIvxnOjPV8XCTQ9gpW4yHSa7t8K3X27WEOpeWQ2
         uWKFaWwY9j13As9OW6UKyTk6vf0Oaobz/NZruE6Xn3Xom3OCaj9N4euuHcASLAA48dI8
         Vhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iNHfHStmGfsWPowCoYf8xBtKgHj0WtHFOUX9NQO2sOs=;
        fh=VXL3WbKOkzZgUJu9J90X2RURUsqt1pdrJjeKAnHTu/Y=;
        b=ZxEvtq2hZ6k0i+9MWMzqy896shtXDv+ZMBfh/oRT8maVfgXy+U4tMzdk+lQ7N82Ww2
         U1OoEOdBIIGduxXtIzIq4+/4Q6fcRGkwXnnEpZ3Brzs97T7IxlPnetqFu1XK37H2B813
         Ka5VcBEAKjeJg3qqSlnyLscvgXmEkiysH7XilLozSTqlTweWPEOmQDzvE9CgXB/51jRy
         Fk6eYZLfQSa918ZZCtY0SWqwOdSiCQwO768WMAXxia4W8nyjrbpbxyps2vJ9nhZnipWS
         2VPrF/Sao8ioil9ws8FGFkcc/aV3aTmYs5VVLBP+kvLcshG5gmwQdoU166qr5SjTrBia
         lqmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999016; x=1779603816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iNHfHStmGfsWPowCoYf8xBtKgHj0WtHFOUX9NQO2sOs=;
        b=cMF+8f8hUWcpVWxomNtrnq3CfwWy2Rej5jPPyZDDQ0xZWmUNU+evixmEtoAGBruVOs
         FJLgJPYgKBFhrnfpomwCv6Tt7YwMDT/HhtDdK8WkvVmuuCpXtPeonf5rY5piK1BjEYXy
         Gf7id7tCirQBvGIxKHUqqre9suen+W7NGGLdcJobpIGyrX6JH1LO3GwU7UDuwVjoRVpo
         4YGJqilBpBPOLsHiuAyjkK+oQVs4gZGoFtkRY8nnaM689PcDz+q6IN2Z4Mxn41hWkEcS
         b35//NpJxaYapv8dcnJQOyDec2owi82xLzI+3yZ/HrzATVvyFojh6yEmgGrJDV7pr9Bj
         bFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999016; x=1779603816;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNHfHStmGfsWPowCoYf8xBtKgHj0WtHFOUX9NQO2sOs=;
        b=f9mXf9NPz86sOW1l29BVSwS1XV12akAZrO+R0RCdlHfXaAWc/ybGBPFh18SWp8h8jV
         jMy6ivBOMbjjPod+k8CDuzXKQzBswufL/q1UALDmHoI2LvfYD+PHTpx+OIiydNGgAQPY
         iuNjCDHojdOzBtujb++/S/U+xVeWXDdWtYekGK34c25M6zL+f7NmrPX7U5YOfjYZNYSe
         GIY3yaH++t3V3qAe0M/jWMRhDiqdA3dJn9L2fM+q4rIdkxT7Vu//ZV4R9JkM5h1UNbqT
         F29XPGwQ/MSB1uqZG/sQ6/FpaupSRGxyLazwHTvDEkLUxUHMHgPYaTd0sof6aXHRkKVB
         iIAg==
X-Forwarded-Encrypted: i=1; AFNElJ+mj/yLghW/bhovtSfFsiVNjmfGbF3ApYJpN/jyLINoZtOI1imHe70rwV8S2cWnZzvZL8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgpwJEBgLkNTp8PSHmjzaZSMmwNwj45OBpTXkR1mvRNnBTXse
	8b7Pome0TKWTniRdEvO8mXf/57EJUCJKapDJMqUfWnJyolTd3xFLjbpWusXbs8eOA30aNstj/6S
	wrDxU6xmr8SIIA+ZjUiCTON+hvq5zxUc=
X-Gm-Gg: Acq92OHltu2inGHeFkTTHHQnwlldjAfQaVB/9/c9vXdlAfmZKPMnLfjGLRAhredAs2z
	VUXUXc/bJN55LGApyp54//SSZSWC6y8JHlcRWPnjvvNiKnVApsjrWUVe5tf1pytikAbHFI1P9TH
	wMal1OeV9xFMSsQ6F68+OV8qqApa3pENYaRPsU1Xx/s7agzInr8EpiVqKDFoh3jI5ZCvgv+6lN8
	3WCuI0oZ5EU+WW5P9tIPuBBzaIHH8hB9ucmPcR3dXVoNVjGQW82TDfsM7bXwhA0XGHnDZKZYBvq
	LlcQAKUu
X-Received: by 2002:a05:6820:6ac4:b0:696:2b09:5988 with SMTP id
 006d021491bc7-69c9458354dmr6929848eaf.40.1778999015690; Sat, 16 May 2026
 23:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Afi0 <capyenglishlite@gmail.com>
Date: Sun, 17 May 2026 06:23:24 +0000
X-Gm-Features: AVHnY4LME0OtMU5JhUBIuPbfrqc7zbWL8lmz-Wc7J6masq56_cBJyVzr88WLLZ8
Message-ID: <CAEABq7efY7w0RrEJHDen8sGVr+gYbeorap+Sv__f_V9T1Ay_Vw@mail.gmail.com>
Subject: Race condition in bpf_arena fault handler leads to page table / range
 tree desynchronization
To: security@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="00000000000062f3060651fd7c5e"

--00000000000062f3060651fd7c5e
Content-Type: multipart/alternative; boundary="00000000000062f3060651fd7c5c"

--00000000000062f3060651fd7c5c
Content-Type: text/plain; charset="UTF-8"

Hi list,

Apologies for initially sending only to Greg. Resending to the full list as
requested.
------------------------------

Component: kernel/bpf/arena.c

Function: arena_vm_fault()

Affected versions: Linux kernel 6.9+

Type: TOCTOU / Race condition

CVSS 3.1: AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:H - 7.8 (High)

SUMMARY

A TOCTOU race condition exists in arena_vm_fault() between the
vmalloc_to_page() check and the subsequent range_tree_clear() call. Both
operations are intended to be atomic with respect to page allocation state,
but are not protected by a common critical section. This leads to
desynchronization between kernel virtual memory mappings and the arena
internal range tree allocator, resulting in a physical page remaining
accessible through a user VMA after being freed back to the page allocator.

VULNERABLE CODE

arena_vm_fault() in kernel/bpf/arena.c:

page = vmalloc_to_page((void *)kaddr);if (page)    goto out;[race
window: concurrent arena_alloc_pages() can map a page at same pgoff
here]ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);

IMPACT

Range tree reports pgoff as available while PTE remains populated.
arena_free_pages() may free the physical page while user VMA mapping
persists. Physical page returned to the page allocator while remaining
accessible through user mapping. Observed as segfault (error 4) in dmesg.

TRIGGER

Reachable unprivileged when kernel.unprivileged_bpf_disabled=0 (default on
Ubuntu < 23.04, Debian, Fedora). With CAP_BPF always reachable. Two
concurrent operations on the same pgoff: Thread A faults in via mmap,
Thread B calls bpf_arena_free_pages() from a sleepable BPF prog during the
window.

SUGGESTED FIX

vmalloc_to_page() check and range_tree_clear() must occur within the same
critical section. arena->lock is already used by arena_vm_open/close and is
appropriate here. arena_vm_fault() is sleepable so taking a mutex is safe.

Patch attached as 0001-bpf-arena-fix-TOCTOU-race-in-arena_vm_fault.patch

Fixes: a7d032218a53 ("bpf: Introduce bpf_arena")

Thanks,

Afi0

--00000000000062f3060651fd7c5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-font-claude-response-body gmail-break-wo=
rds gmail-whitespace-normal gmail-leading-[1.7]">Hi list,</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Apologies for initially sending only to Gre=
g. Resending to the full list as requested.</p>
<hr class=3D"gmail-border-border-200 gmail-border-t-0.5 gmail-my-3 gmail-mx=
-1.5">
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Component: kernel/bpf/arena.c=C2=A0</p><p=
 class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitespac=
e-pre-wrap gmail-leading-[1.7]">Function: arena_vm_fault()=C2=A0</p><p clas=
s=3D"gmail-font-claude-response-body gmail-break-words gmail-whitespace-pre=
-wrap gmail-leading-[1.7]">Affected versions: Linux kernel 6.9+=C2=A0</p><p=
 class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitespac=
e-pre-wrap gmail-leading-[1.7]">Type: TOCTOU / Race condition=C2=A0</p><p c=
lass=3D"gmail-font-claude-response-body gmail-break-words gmail-whitespace-=
pre-wrap gmail-leading-[1.7]">CVSS 3.1: AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:H=
 - 7.8 (High)</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">SUMMARY</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">A TOCTOU race condition exists in arena_vm_=
fault() between the vmalloc_to_page() check and the subsequent range_tree_c=
lear() call. Both operations are intended to be atomic with respect to page=
 allocation state, but are not protected by a common critical section. This=
 leads to desynchronization between kernel virtual memory mappings and the =
arena internal range tree allocator, resulting in a physical page remaining=
 accessible through a user VMA after being freed back to the page allocator=
.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">VULNERABLE CODE</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">arena_vm_fault() in kernel/bpf/arena.c:</p>
<div role=3D"group" aria-label=3D"Code" tabindex=3D"0" class=3D"gmail-relat=
ive gmail-group/copy gmail-bg-bg-000/50 gmail-border-0.5 gmail-border-borde=
r-400 gmail-rounded-lg gmail-focus:outline-none gmail-focus-visible:ring-2 =
gmail-focus-visible:ring-accent-100"><div class=3D"gmail-sticky gmail-opaci=
ty-0 gmail-group-hover/copy:opacity-100 gmail-group-focus-within/copy:opaci=
ty-100 gmail-top-2 gmail-py-2 gmail-h-12 gmail-w-0 gmail-float-right"><div =
class=3D"gmail-absolute gmail-right-0 gmail-h-8 gmail-px-2 gmail-items-cent=
er gmail-inline-flex gmail-z-10"><button class=3D"gmail-inline-flex gmail-i=
tems-center gmail-justify-center gmail-relative gmail-isolate gmail-shrink-=
0 gmail-can-focus gmail-select-none gmail-disabled:pointer-events-none gmai=
l-disabled:opacity-50 gmail-disabled:shadow-none gmail-disabled:drop-shadow=
-none gmail-border-transparent gmail-transition gmail-font-base gmail-durat=
ion-300 ease-[cubic-bezier(0.165,0.85,0.45,1)] gmail-h-8 gmail-w-8 gmail-ro=
unded-md gmail-backdrop-blur-md gmail-_fill_10ocf_9 gmail-_ghost_10ocf_96" =
type=3D"button" aria-label=3D"Copy to clipboard"><div class=3D"gmail-relati=
ve"><div class=3D"gmail-transition-all gmail-opacity-100 gmail-scale-100" s=
tyle=3D"width:20px;height:20px;display:flex"></div><div class=3D"gmail-abso=
lute gmail-inset-0 gmail-flex gmail-items-center gmail-justify-center"><div=
 class=3D"gmail-transition-all gmail-opacity-0 gmail-scale-50" style=3D"wid=
th:20px;height:20px;display:flex"></div></div></div></button></div></div><d=
iv class=3D"gmail-overflow-x-auto"><pre class=3D"gmail-code-block__code gma=
il-!my-0 gmail-!rounded-lg gmail-!text-sm gmail-!leading-relaxed gmail-p-3.=
5" style=3D"color:rgb(20,24,31);background:transparent;font-family:var(--fo=
nt-mono)"><code style=3D"color:rgb(20,24,31);background:transparent;font-fa=
mily:var(--font-mono);white-space:pre-wrap"><span><span>page =3D vmalloc_to=
_page((void *)kaddr);
</span></span><span>if (page)
</span><span>    goto out;
</span><span>[race window: concurrent arena_alloc_pages() can map a page at=
 same pgoff here]
</span><span>ret =3D range_tree_clear(&amp;arena-&gt;rt, vmf-&gt;pgoff, 1);=
</span></code></pre></div></div>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">IMPACT</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Range tree reports pgoff as available while=
 PTE remains populated. arena_free_pages() may free the physical page while=
 user VMA mapping persists. Physical page returned to the page allocator wh=
ile remaining accessible through user mapping. Observed as segfault (error =
4) in dmesg.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">TRIGGER</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Reachable unprivileged when kernel.unprivil=
eged_bpf_disabled=3D0 (default on Ubuntu &lt; 23.04, Debian, Fedora). With =
CAP_BPF always reachable. Two concurrent operations on the same pgoff: Thre=
ad A faults in via mmap, Thread B calls bpf_arena_free_pages() from a sleep=
able BPF prog during the window.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">SUGGESTED FIX</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">vmalloc_to_page() check and range_tree_clea=
r() must occur within the same critical section. arena-&gt;lock is already =
used by arena_vm_open/close and is appropriate here. arena_vm_fault() is sl=
eepable so taking a mutex is safe.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Patch attached as 0001-bpf-arena-fix-TOCTOU=
-race-in-arena_vm_fault.patch</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Fixes: a7d032218a53 (&quot;bpf: Introduce b=
pf_arena&quot;)</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Thanks,=C2=A0</p><p class=3D"gmail-font-c=
laude-response-body gmail-break-words gmail-whitespace-pre-wrap gmail-leadi=
ng-[1.7]">Afi0</p><br></div>

--00000000000062f3060651fd7c5c--
--00000000000062f3060651fd7c5e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-bpf-arena-fix-TOCTOU-race-in-arena_vm_fault.patch"
Content-Disposition: attachment; 
	filename="0001-bpf-arena-fix-TOCTOU-race-in-arena_vm_fault.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mp9e1zi00>
X-Attachment-Id: f_mp9e1zi00

RnJvbSBhMWIyYzNkNGU1ZjZhMWIyYzNkNGU1ZjZhMWIyYzNkNGU1ZjZhMWIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBZmkwIDxjYXB5ZW5nbGlzaGxpdGVAZ21haWwuY29tPgpEYXRl
OiBTYXQsIDE2IE1heSAyMDI2IDExOjU4OjAwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gYnBmOiBh
cmVuYTogZml4IFRPQ1RPVSByYWNlIGluIGFyZW5hX3ZtX2ZhdWx0KCkKClRoZSB2bWFsbG9jX3Rv
X3BhZ2UoKSBjaGVjayBhbmQgcmFuZ2VfdHJlZV9jbGVhcigpIGluIGFyZW5hX3ZtX2ZhdWx0KCkK
YXJlIG5vdCBwcm90ZWN0ZWQgYnkgYSBjb21tb24gY3JpdGljYWwgc2VjdGlvbi4gQSBjb25jdXJy
ZW50CmJwZl9hcmVuYV9mcmVlX3BhZ2VzKCkgY2FsbCBvbiB0aGUgc2FtZSBwZ29mZiBjYW4gcmV0
dXJuIHRoZSBwaHlzaWNhbApwYWdlIHRvIHRoZSBhbGxvY2F0b3IgYmV0d2VlbiB0aGVzZSB0d28g
b3BlcmF0aW9ucy4gYXJlbmFfdm1fZmF1bHQoKQp0aGVuIGluc2VydHMgYSBzdGFsZSBvciBhbHJl
YWR5LWZyZWVkIHBhZ2UgaW50byB0aGUgdXNlciBQVEUsIHJlc3VsdGluZwppbiBhIFNJR1NFR1Yg
b24gbmV4dCBhY2Nlc3Mgb3IgYSBzaWxlbnQgdXNlLWFmdGVyLWZyZWUuCgpGaXg6IGFjcXVpcmUg
YXJlbmEtPmxvY2sgYmVmb3JlIHZtYWxsb2NfdG9fcGFnZSgpIGFuZCBob2xkIGl0IHRocm91Z2gK
cmFuZ2VfdHJlZV9jbGVhcigpLCBtYWtpbmcgdGhlIGNoZWNrLWFuZC1jbGFpbSBhdG9taWMgd2l0
aCByZXNwZWN0IHRvCmNvbmN1cnJlbnQgYWxsb2NhdG9ycyBhbmQgZnJlZSBvcGVyYXRpb25zLgoK
YXJlbmEtPmxvY2sgaXMgYSBtdXRleCBhbHJlYWR5IHVzZWQgYnkgYXJlbmFfdm1fb3BlbigpIGFu
ZAphcmVuYV92bV9jbG9zZSgpIGZvciB2bWFfbGlzdCBzZXJpYWxpemF0aW9uLiBSZXVzaW5nIGl0
IGhlcmUgaXMKY29uc2lzdGVudCB3aXRoIHRoZSBleGlzdGluZyBsb2NraW5nIG1vZGVsIGFuZCBh
dm9pZHMgaW50cm9kdWNpbmcgYQpuZXcgbG9jay4gYXJlbmFfdm1fZmF1bHQoKSBydW5zIGluIHBh
Z2UgZmF1bHQgY29udGV4dCB3aXRoCm1tYXBfcmVhZF9sb2NrIGhlbGQgYW5kIGlzIHNsZWVwYWJs
ZSwgc28gdGFraW5nIGEgbXV0ZXggaXMgc2FmZS4KClRoZSBwdGVfbm9uZSgpIGNoZWNrIGluc2lk
ZSBhcHBseV9yYW5nZV9zZXRfY2IoKSBpcyBub3QgYSBzdWZmaWNpZW50Cmd1YXJkOiBpdCBwcmV2
ZW50cyBkb3VibGUtbWFwcGluZyBidXQgZG9lcyBub3QgcHJldmVudCB0aGUgcmFuZ2UgdHJlZQpk
ZXN5bmNocm9uaXphdGlvbiB0aGF0IG9jY3VycyB3aGVuIHRoZSByYWNlIGlzIGxvc3QsIGxlYXZp
bmcgcGdvZmYKbWFya2VkIGZyZWUgd2hpbGUgdGhlIFBURSByZW1haW5zIHBvcHVsYXRlZC4KCkZp
eGVzOiBhN2QwMzIyMThhNTMgKCJicGY6IEludHJvZHVjZSBicGZfYXJlbmEiKQpDYzogQWxleGVp
IFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz4KQ2M6IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlp
QGtlcm5lbC5vcmc+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEFm
aTAgPGNhcHllbmdsaXNobGl0ZUBnbWFpbC5jb20+Ci0tLQoga2VybmVsL2JwZi9hcmVuYS5jIHwg
MjIgKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9hcmVuYS5jIGIva2Vy
bmVsL2JwZi9hcmVuYS5jCmluZGV4IGExYjJjM2QuLmU0ZjVjNmQgMTAwNjQ0Ci0tLSBhL2tlcm5l
bC9icGYvYXJlbmEuYworKysgYi9rZXJuZWwvYnBmL2FyZW5hLmMKQEAgLVhYWCw3ICtYWFgsNyBA
QCBzdGF0aWMgdm1fZmF1bHRfdCBhcmVuYV92bV9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikK
IAlzdHJ1Y3QgYnBmX21hcCAqbWFwID0gdm1mLT52bWEtPnZtX2ZpbGUtPnByaXZhdGVfZGF0YTsK
IAlzdHJ1Y3QgYnBmX2FyZW5hICphcmVuYSA9IGNvbnRhaW5lcl9vZihtYXAsIHN0cnVjdCBicGZf
YXJlbmEsIG1hcCk7CiAJc3RydWN0IHBhZ2UgKnBhZ2U7Ci0JbG9uZyBrYmFzZSwga2FkZHI7CisJ
bG9uZyBrYmFzZSwga2FkZHI7CiAJaW50IHJldDsKIAogCWtiYXNlID0gYnBmX2FyZW5hX2dldF9r
ZXJuX3ZtX3N0YXJ0KGFyZW5hKTsKQEAgLVhYWCwxMiArWFhYLDI0IEBAIHN0YXRpYyB2bV9mYXVs
dF90IGFyZW5hX3ZtX2ZhdWx0KHN0cnVjdCB2bV9mYXVsdCAqdm1mKQogCWtiYXNlID0gYnBmX2Fy
ZW5hX2dldF9rZXJuX3ZtX3N0YXJ0KGFyZW5hKTsKIAlrYWRkciA9IGtiYXNlICsgKHUzMikodm1m
LT5hZGRyZXNzKTsKIAorCS8qCisJICogQWNxdWlyZSBhcmVuYS0+bG9jayBiZWZvcmUgdm1hbGxv
Y190b19wYWdlKCkgYW5kIGhvbGQgaXQgdGhyb3VnaAorCSAqIHJhbmdlX3RyZWVfY2xlYXIoKSB0
byBjbG9zZSB0aGUgVE9DVE9VIHdpbmRvdy4KKwkgKgorCSAqIFdpdGhvdXQgdGhpcyBsb2NrLCBh
IGNvbmN1cnJlbnQgYnBmX2FyZW5hX2ZyZWVfcGFnZXMoKSBvbiB0aGUKKwkgKiBzYW1lIHBnb2Zm
IGNhbiBydW4gYmV0d2VlbiB2bWFsbG9jX3RvX3BhZ2UoKSByZXR1cm5pbmcgTlVMTCBhbmQKKwkg
KiByYW5nZV90cmVlX2NsZWFyKCkgY29tcGxldGluZzoKKwkgKgorCSAqICAgYXJlbmFfdm1fZmF1
bHQoKSAgICAgICAgICAgICAgYnBmX2FyZW5hX2ZyZWVfcGFnZXMoKQorCSAqICAgdm1hbGxvY190
b19wYWdlKCkgPSBOVUxMCisJICogICBbd2luZG93XSAgICAgICAgICAgICAgICAgICAgICBwYWdl
IGZyZWVkLCBQVEUgemVyb2VkIGluIGtlcm4gdm1hCisJICogICByYW5nZV90cmVlX2NsZWFyKHBn
b2ZmKQorCSAqICAgYWxsb2NfcGFnZSgpICsgdm1faW5zZXJ0X3BhZ2UoKSAtPiBzdGFsZSBQVEUg
aW4gdXNlciB2bWEKKwkgKgorCSAqIFRoZSB1c2VyIFZNQSB0aGVuIGhvbGRzIGEgcmVmZXJlbmNl
IHRvIGEgZnJlZWQgcGh5c2ljYWwgcGFnZS4KKwkgKiBOZXh0IGFjY2VzcyBwcm9kdWNlcyBTSUdT
RUdWIG9yIHNpbGVudCB1c2UtYWZ0ZXItZnJlZS4KKwkgKi8KKwlndWFyZChtdXRleCkoJmFyZW5h
LT5sb2NrKTsKKwogCXBhZ2UgPSB2bWFsbG9jX3RvX3BhZ2UoKHZvaWQgKilrYWRkcik7CiAJaWYg
KHBhZ2UpCiAJCWdvdG8gb3V0OwotCiAJcmV0ID0gcmFuZ2VfdHJlZV9jbGVhcigmYXJlbmEtPnJ0
LCB2bWYtPnBnb2ZmLCAxKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gVk1fRkFVTFRfU0lHQlVTOwot
LSAKMi4zOS4wCg==
--00000000000062f3060651fd7c5e--
