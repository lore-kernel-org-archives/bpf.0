Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC20473C65
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539269; cv=pass; b=WwxTgDXQeAmIv8quo4g8zgZVaIw5j1vjeyuLSkqp8f2yNoinH+2bc0KEHBfUK6OGZv6zGoU6iILoN4Iwl6N6xF1PhAwEZQa79hnMhtYXV1LAkH2G7B/McW01PXhl80s4eMbpvovHvnUi4fQ9bDDosUYNix9DN3jlON5DFNQGEO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539269; c=relaxed/simple;
	bh=7KEbSS5yIuGvkunDI7vtFDqxrkatGXh9/uj3VGZQuos=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RrusuKObnVU2ERYEYSslelaCkWoKfevbM/ciweZ7FjnKsyjGeJgRhbXEcxXZCES3jGVyfDDeB+YMgMWbbkRlZs96RatQsQ1H06ePO3CV3mAJWBqh5DbQWfexPq8sBQv9wGOn7v0tnCpVeBISOne2OVnpGTQ/7jHT5z1wBH8ah6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFnSozyI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGitWIqi; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFnSozyI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGitWIqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788539266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xBpAfWkoWfrycve1iRc1QvCfa1f5Q+Ghrx+KJql/Z00=;
	b=KFnSozyIff5spgZJ9IHTUQNZpp2o63dO9q1gZmjJCguqLZum4V4rUFbwavOYRtXLnktGrL
	U9BPhoixffTfuqRqEUXkOmMY5cR42N8tIcCRf3xr0bUV2nUmPt8V226v51s3NY3sj/r0TW
	xE4CqZ8u7ymOpXy2yalK66RP1t3YQNc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-NgvIlFYEOw2_zdvY6JcszA-1; Fri, 04 Sep 2026 12:27:44 -0400
X-MC-Unique: NgvIlFYEOw2_zdvY6JcszA-1
X-Mimecast-MFC-AGG-ID: NgvIlFYEOw2_zdvY6JcszA_1788539263
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a36d1d10f0so6495641fa.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 09:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788539263; cv=none;
        d=google.com; s=arc-20260327;
        b=G1rt2Ur9AK3gYoOmTCQ7Sfojds+gHfeitbXdsrUPyxIhIpo0TAK41HklzSecZAcTaQ
         nAA7IGiviUQmfEm4cGfgcipZSPprxi4cECa4AzbXByhLTosK8Yi5zai7ccJIbvjmFO/g
         meVVkE0ak522UKR0wRC8moPj6zpf2Lx7Zk9RK6TL6SgS3u/sp9IL4vybCJBlOt4A7LxD
         wUJZbiOXm/YpWql7eWZ4LiCwgEJLhV6YejKN7Wi9rS5VmY7OQHFZ3252wjzH0wDonjqQ
         2Z9Us+DmVAyULB/l4KwCUAo9iyB25CGnrQvWzeK6VpQpodx8BBms4lhK4nqetPCBK2eO
         tGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xBpAfWkoWfrycve1iRc1QvCfa1f5Q+Ghrx+KJql/Z00=;
        fh=p98rn6sAiNu/UG1ingwCb9qqnt4jVaKv4+wKsLZlYfk=;
        b=l9iXM/EY1O0VvKKMHz9xSwzvauoNeSb6I+jXOb4iQLCNP5ufIUoKy+7Ub3vYxP2gcJ
         r9vwCFefUPzF57XemXO/WFCQNEv8RYsD9fIboUM2GuBJMX4F2YV2ocmBZz2UNQdEwsUc
         eq7zl2SHC6v+oADugTWqKmanehfKnuAoFKixecAEe53Jt+XkLau2yFjkPmORW8bv6DmZ
         cy2sroV7RKqBcp+TGHcwhRLM2mxsdkMa+Fzu84L/OJgLAsIHqPie/J0dtYwyuVM92UzP
         K2HxTxh9p2AH1O8eMS5qgd1vY4Bkc9Uh+Bi5DRhQO0VVbpEVeJ57939xLCwQGlPSKs37
         1OWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788539263; x=1789144063; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xBpAfWkoWfrycve1iRc1QvCfa1f5Q+Ghrx+KJql/Z00=;
        b=YGitWIqi2+spgzOlHEZBpvza2bCv0Nb405Ujle5Zasl+IyXWjfjOd60aTZNqNIBaEx
         QkoOu6KAr/+8+B+1OsFbQZvrJPtIGVnrzJ5416ROCOqL7rMa41IHZ0slgdocW460h4c4
         oJDNYNiKFcW9Wyav8WTMc+9GxatmsAVpt91UN8YcldiHHnC9rOQOFV1bTIjPWdbg9tRL
         shSsXTLypJ3rN07oiu37Yp4c9e7JP6E2j2Q+XoZXXIKp5PEBQppWa2U+ThpbMd0g3nqb
         fmpy5xFGDWYKBKI9IdGyKNkWfyYtRFYDRIQVEoRrhQpHlqYUya0PIBEH/874sfbVQNsM
         Nyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539263; x=1789144063;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xBpAfWkoWfrycve1iRc1QvCfa1f5Q+Ghrx+KJql/Z00=;
        b=MK1CBX2c3Z9+6tE12q/D+dxQCDhrXehkIr5P1Xb+qCp+5o4CkB/nEPUKMh3kGVDaNR
         p1L5NDu8cr0J0ynwT9lf4x1PFORYVaGfBtne+d/BtFvftkR7m3kxDzr9BM9OcNO2B65y
         zEv9UWS5/QdMDBsLZPCfA5g5Kx38jUr/zgmN8aqITc4vyBg5CRFk7omiIYRlwgmOPhuG
         eK88jgvRbOyfqucylf7MPP2ALFZnupIdfrtl357nhxofpWpjyPvI/Xv+atpCQpUyCCN0
         QCRbSPtsXcv5TvcixK2Fx+nLzx1MFtk+09myHN7+l1bjQ0wcNtf08Kdq/S2oLnBEC1tt
         OTqw==
X-Gm-Message-State: AFuF++n1nl9ZfA7U6JOxw10x1cGzuSa7v+v3+burA2eQBHYTroCAvrlu
	EQ79Cq7xCMc8RjlRkiZPYAyIN7R9or6tqAn/IwQ6/1XCvxDLutDObFFhMCyQ9fkg9tz4M9P4orD
	I+h0dDUV/QU8F+ndnz7DbVKRd+o/sslc1TMrnGu5uKMDCRIzjPb+TX6j4imEHTv8l8uPn/B5sqr
	Fn2eZC0xMhWMSSVbTZduwBGIhooYWsqExRqCRfqfhIiQ==
X-Gm-Gg: AYBFou1yEGXiwFypq8myH8zumBK8NgOsviEWF5vXfFWdC+KbU1KDg9PWj+mJ2zJpIAo
	Cg8a3Gq7kRq/6QWXtaoGTR04Pxac0Kl0pCmqy8cPzlYT8DztaUD3MVMdE91DhpKCuwUZE8eTVyJ
	xW7ktm2OUt9cILZpjz03rwqU4OcnmkKnPYCcabj8JTgR8Zptzu6HHWWR9M
X-Received: by 2002:a05:651c:1507:b0:394:635:70b1 with SMTP id 38308e7fff4ca-3a371a9284dmr10943941fa.3.1788539262864;
        Fri, 04 Sep 2026 09:27:42 -0700 (PDT)
X-Received: by 2002:a05:651c:1507:b0:394:635:70b1 with SMTP id
 38308e7fff4ca-3a371a9284dmr10943881fa.3.1788539262396; Fri, 04 Sep 2026
 09:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sandipan Roy <saroy@redhat.com>
Date: Fri, 4 Sep 2026 21:57:29 +0530
X-Gm-Features: AcwNN1XAfAHUiY2qTep68LcqWXXU5CzW9kgEqLww3ExLwtGg_uAIAXNcsInK-Ps
Message-ID: <CAJ33NAX8=B6zwXDfjTvyoAOV_=1NZADCzCjCk4xtoPLE==yiPQ@mail.gmail.com>
Subject: [PATCH] bpf: fix dangling jump table entries for verified indirect
 jump targets
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, jolsa@kernel.org, security@kernel.org
Content-Type: multipart/mixed; boundary="00000000000067210a065aaabfbc"

--00000000000067210a065aaabfbc
Content-Type: text/plain; charset="UTF-8"

Resending with the correct Signed-off-by.  (My earlier send carried a
   placeholder sign-off from a local test setup; please disregard it.)


Hi,

While reviewing the BPF subsystem's recently introduced indirect jump
support (BPF_MAP_TYPE_INSN_ARRAY / `gotox`), I found a verifier soundness
bug: a program that passes verification can, at run time, execute a jump
through a NULL (or stale) code pointer, causing a kernel oops/panic. I
believe this affects all kernels since the feature was added.

The core problem is the interaction between post-verification instruction
removal and the insn_array jump table:

- `bpf_opt_remove_nops()` removes instructions byte-equal to `JA +0` even
  when they are targets of a verified `gotox`, because it does not check
  `insn_aux_data[].indirect_target`.
- When such a target is removed, `bpf_insn_array_adjust_after_remove()`
  marks the map entries `INSN_DELETED`, the JIT skips them and leaves
  `ips[]` NULL (or stale), and `bpf_insn_array_ready()` skips validation
  of `INSN_DELETED` entries.

The result is that a verified `gotox rX` can execute `jmp *rX` with
`rX == NULL`. I reproduced this on the current mainline (v7.3-rc1,
commit bc35965f6940) with a minimal BPF program: the load succeeds and
running it produces "BUG: kernel NULL pointer dereference" with
"#PF: supervisor instruction fetch" at RIP 0x0. A map previously bound
to another program can instead leave a stale pointer into a freed JIT
image (latent use-after-free).

While validating the fix I also noticed a related lifecycle bug:
`bpf_insn_array_release()` is only invoked from verifier error paths, so
after a successful load the map remains permanently "used" (the map can
never be bound to another program, failing with -EBUSY) and `ips[]` keeps
pointing into the freed jitted image of the unloaded program.

The attached patch fixes all of these:

1. Never remove indirect jump targets in `bpf_opt_remove_nops()`, and
   hard-guarantee it in `verifier_remove_insns()` by rejecting any removal
   of an instruction flagged as an indirect jump target.
2. Turn the final safety gate in `bpf_insn_array_ready()` into a hard
   rejection of `INSN_DELETED` entries instead of silently skipping them.
3. Call `bpf_insn_array_release()` from `__bpf_free_used_maps()` when the
   bound program is freed, and clear the stale per-entry state
   (`xlated_off`, `ips[]`) there so a subsequent bind cannot inherit
   dangling pointers.


Thanks,
Sandipan Roy
Senior Product Security Engineer, Red Hat

--00000000000067210a065aaabfbc
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-bpf-fix-dangling-jump-table-entries-for-verified-indirect-jump-targets.patch"
Content-Disposition: attachment; 
	filename="0001-bpf-fix-dangling-jump-table-entries-for-verified-indirect-jump-targets.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtn62ttm0>
X-Attachment-Id: f_mtn62ttm0

RnJvbSAwOWY5ZDNmZGMzODNiMmIxMTgzODY4MjRiNDAzMzdjMTJhY2IwNWMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW5kaXBhbiBSb3kgPHNhcm95QHJlZGhhdC5jb20+CkRhdGU6
IEZyaSwgNCBTZXAgMjAyNiAyMTo0MTo0MiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGJwZjogZml4
IGRhbmdsaW5nIGp1bXAgdGFibGUgZW50cmllcyBmb3IgdmVyaWZpZWQgaW5kaXJlY3QKIGp1bXAg
dGFyZ2V0cwoKQlBGX01BUF9UWVBFX0lOU05fQVJSQVkgbGV0cyBhIHByb2dyYW0gcGVyZm9ybSBp
bmRpcmVjdCBqdW1wcyAoYGdvdG94CnJYYCwgQlBGX0pNUHxCUEZfSkF8QlBGX1gpLiAgRm9yIGV2
ZXJ5IG1hcCBpbmRleCByZWFjaGFibGUgYnkgclggdGhlCnZlcmlmaWVyIHZlcmlmaWVzIHRoZSB0
YXJnZXQgaW5zdHJ1Y3Rpb24sIGFuZCB0aGUgSklUIGxhdGVyIHJlY29yZHMgdGhlCmppdHRlZCB0
YXJnZXQgYWRkcmVzcyBpbiBpbnNuX2FycmF5LT5pcHNbXS4KCkFmdGVyIHZlcmlmaWNhdGlvbiB0
aGUgcHJpdmlsZWdlZCBwYXNzIGJwZl9vcHRfcmVtb3ZlX25vcHMoKSByZW1vdmVzCmluc3RydWN0
aW9ucyBieXRlLWVxdWFsIHRvIEpBICswIChOT1ApIHdpdGhvdXQgY2hlY2tpbmcgd2hldGhlciB0
aGV5IGFyZQp0YXJnZXRzIG9mIGEgdmVyaWZpZWQgaW5kaXJlY3QganVtcC4gIElmIHN1Y2ggYSB0
YXJnZXQgaXMgcmVtb3ZlZCwKYnBmX2luc25fYXJyYXlfYWRqdXN0X2FmdGVyX3JlbW92ZSgpIG1h
cmtzIHRoZSBjb3JyZXNwb25kaW5nIG1hcCBlbnRyaWVzCklOU05fREVMRVRFRCwgdGhlIEpJVCB0
aGVuIHNraXBzIHRoZW0gYW5kIGxlYXZlcyBpcHNbXSBOVUxMIChvciBzdGFsZQpmcm9tIGEgcHJl
dmlvdXNseSBib3VuZCBwcm9ncmFtKSwgd2hpbGUgYnBmX2luc25fYXJyYXlfcmVhZHkoKSBza2lw
cwp2YWxpZGF0aW9uIG9mIElOU05fREVMRVRFRCBlbnRyaWVzLiAgVGhlIHJlc3VsdCBpcyBhIHBy
b2dyYW0gdGhhdCBwYXNzZXMKdmVyaWZpY2F0aW9uIGFuZCwgYXQgcnVuIHRpbWUsIGV4ZWN1dGVz
IGBqbXAgKnJYYCB3aXRoIHJYID09IE5VTEwgb3IgYQpkYW5nbGluZyBwb2ludGVyLCBjYXVzaW5n
IGEga2VybmVsIG9vcHMgb3IgcGFuaWMuCgpGaXggaXQgYnk6Ci0gbmV2ZXIgcmVtb3ZpbmcgaW5z
dHJ1Y3Rpb25zIG1hcmtlZCBpbnNuX2F1eF9kYXRhW10uaW5kaXJlY3RfdGFyZ2V0IGluCiAgYnBm
X29wdF9yZW1vdmVfbm9wcygpOwotIHJlamVjdGluZywgaW4gdmVyaWZpZXJfcmVtb3ZlX2luc25z
KCksIGFueSByZW1vdmFsIG9mIGFuIGluc3RydWN0aW9uCiAgZmxhZ2dlZCBhcyBhbiBpbmRpcmVj
dCBqdW1wIHRhcmdldCBhcyBhIGhhcmQgZ3VhcmFudGVlIGZvciBhbGwgcmVtb3ZhbAogIHBhc3Nl
czsKLSB0dXJuaW5nIHRoZSBmaW5hbCBzYWZldHkgZ2F0ZSBpbiBicGZfaW5zbl9hcnJheV9yZWFk
eSgpIGludG8gYSBoYXJkCiAgcmVqZWN0aW9uIG9mIElOU05fREVMRVRFRCBlbnRyaWVzIGluc3Rl
YWQgb2Ygc2lsZW50bHkgc2tpcHBpbmcgdGhlbS4KCkFkZGl0aW9uYWxseSwgYnBmX2luc25fYXJy
YXlfcmVsZWFzZSgpIHdhcyBvbmx5IGludm9rZWQgZnJvbSB2ZXJpZmllcgplcnJvciBwYXRocywg
c28gdGhlIGluc25fYXJyYXkgbWFwIHN0YXllZCBib3VuZCBmb3JldmVyIGFmdGVyIGEKc3VjY2Vz
c2Z1bCBsb2FkOiB0aGUgbWFwJ3MgdXNlZCBmbGFnIHdhcyBuZXZlciBjbGVhcmVkLCBtYWtpbmcg
dGhlIG1hcAp1bnVzYWJsZSBmb3Igc3Vic2VxdWVudCBwcm9ncmFtcywgYW5kIGlwc1tdIGtlcHQg
cG9pbnRpbmcgaW50byB0aGUgZnJlZWQKaml0dGVkIGltYWdlIG9mIHRoZSB1bmxvYWRlZCBwcm9n
cmFtLiAgQ2FsbCBicGZfaW5zbl9hcnJheV9yZWxlYXNlKCkKZnJvbSBfX2JwZl9mcmVlX3VzZWRf
bWFwcygpIHdoZW4gdGhlIHByb2dyYW0gaXMgZnJlZWQsIGFuZCBjbGVhciB0aGUKc3RhbGUgcGVy
LWVudHJ5IHN0YXRlICh4bGF0ZWRfb2ZmIGFuZCBpcHNbXSkgdGhlcmUuCgpGaXhlczogNDkzZDll
MGQ2MDgzICgiYnBmLCB4ODY6IGFkZCBzdXBwb3J0IGZvciBpbmRpcmVjdCBqdW1wcyIpClNpZ25l
ZC1vZmYtYnk6IFNhbmRpcGFuIFJveSA8c2Fyb3lAcmVkaGF0LmNvbT4KLS0tCiBrZXJuZWwvYnBm
L2JwZl9pbnNuX2FycmF5LmMgfCAyMCArKysrKysrKysrKysrKysrKysrLQoga2VybmVsL2JwZi9j
b3JlLmMgICAgICAgICAgIHwgIDggKysrKysrKysKIGtlcm5lbC9icGYvZml4dXBzLmMgICAgICAg
ICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwgNTEgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2JwZl9p
bnNuX2FycmF5LmMgYi9rZXJuZWwvYnBmL2JwZl9pbnNuX2FycmF5LmMKaW5kZXggYTJmODRhZmU2
ZjdjLi44NDk4M2RlYzY0MjYgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9icGYvYnBmX2luc25fYXJyYXku
YworKysgYi9rZXJuZWwvYnBmL2JwZl9pbnNuX2FycmF5LmMKQEAgLTIxNSw4ICsyMTUsMTUgQEAg
aW50IGJwZl9pbnNuX2FycmF5X3JlYWR5KHN0cnVjdCBicGZfbWFwICptYXApCiAJaW50IGk7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgbWFwLT5tYXhfZW50cmllczsgaSsrKSB7CisJCS8qCisJCSAqIEEg
dHJhY2tlZCBpbnN0cnVjdGlvbiB0aGF0IHdhcyBkZWxldGVkIGlzIGEgYnJva2VuIGp1bXAKKwkJ
ICogdGFibGUgZW50cnk6IHRoZSBKSVQgbmV2ZXIgZmlsbHMgaW5zbl9hcnJheS0+aXBzW2ldIGZv
ciBpdCwKKwkJICogc28gYSB2ZXJpZmllZCBgZ290b3hgIGNvdmVyaW5nIHRoaXMgaW5kZXggd291
bGQganVtcCB0aHJvdWdoCisJCSAqIGEgTlVMTCBvciBzdGFsZSBjb2RlIHBvaW50ZXIuICBSZWpl
Y3Qgc3VjaCBwcm9ncmFtcyBpbnN0ZWFkCisJCSAqIG9mIHNpbGVudGx5IHNraXBwaW5nIHRoZSBl
bnRyeS4KKwkJICovCiAJCWlmIChpbnNuX2FycmF5LT52YWx1ZXNbaV0ueGxhdGVkX29mZiA9PSBJ
TlNOX0RFTEVURUQpCi0JCQljb250aW51ZTsKKwkJCXJldHVybiAtRUZBVUxUOwogCQlpZiAoIWlu
c25fYXJyYXktPmlwc1tpXSkKIAkJCXJldHVybiAtRUZBVUxUOwogCX0KQEAgLTIyNyw4ICsyMzQs
MTkgQEAgaW50IGJwZl9pbnNuX2FycmF5X3JlYWR5KHN0cnVjdCBicGZfbWFwICptYXApCiB2b2lk
IGJwZl9pbnNuX2FycmF5X3JlbGVhc2Uoc3RydWN0IGJwZl9tYXAgKm1hcCkKIHsKIAlzdHJ1Y3Qg
YnBmX2luc25fYXJyYXkgKmluc25fYXJyYXkgPSBjYXN0X2luc25fYXJyYXkobWFwKTsKKwlpbnQg
aTsKIAogCWF0b21pY19zZXQoJmluc25fYXJyYXktPnVzZWQsIDApOworCisJLyoKKwkgKiBSZXNl
dCB0aGUgcGVyLWVudHJ5IHN0YXRlIHNvIGEgc3Vic2VxdWVudCBiaW5kIGNhbm5vdCBvYnNlcnZl
IGEKKwkgKiBzdGFsZSB4bGF0ZWQgb2Zmc2V0IG9yIGluaGVyaXQgcG9pbnRlcnMgaW50byBhIGZy
ZWVkIGppdHRlZCBpbWFnZQorCSAqIG9mIHRoZSBwcmV2aW91c2x5IGJvdW5kIHByb2dyYW0uCisJ
ICovCisJZm9yIChpID0gMDsgaSA8IG1hcC0+bWF4X2VudHJpZXM7IGkrKykgeworCQlpbnNuX2Fy
cmF5LT52YWx1ZXNbaV0ueGxhdGVkX29mZiA9IGluc25fYXJyYXktPnZhbHVlc1tpXS5vcmlnX29m
ZjsKKwkJaW5zbl9hcnJheS0+aXBzW2ldID0gMDsKKwl9CiB9CiAKIHZvaWQgYnBmX2luc25fYXJy
YXlfYWRqdXN0KHN0cnVjdCBicGZfbWFwICptYXAsIHUzMiBvZmYsIHUzMiBsZW4pCmRpZmYgLS1n
aXQgYS9rZXJuZWwvYnBmL2NvcmUuYyBiL2tlcm5lbC9icGYvY29yZS5jCmluZGV4IGQ1NWU3Mzdl
ZDc1YS4uYzkwZmNmMmM5NTkyIDEwMDY0NAotLS0gYS9rZXJuZWwvYnBmL2NvcmUuYworKysgYi9r
ZXJuZWwvYnBmL2NvcmUuYwpAQCAtMzAyOCw2ICszMDI4LDE0IEBAIHZvaWQgX19icGZfZnJlZV91
c2VkX21hcHMoc3RydWN0IGJwZl9wcm9nX2F1eCAqYXV4LAogCQkJbWFwLT5vcHMtPm1hcF9wb2tl
X3VudHJhY2sobWFwLCBhdXgpOwogCQlpZiAoc2xlZXBhYmxlKQogCQkJYXRvbWljNjRfZGVjKCZt
YXAtPnNsZWVwYWJsZV9yZWZjbnQpOworCQlpZiAobWFwLT5tYXBfdHlwZSA9PSBCUEZfTUFQX1RZ
UEVfSU5TTl9BUlJBWSkKKwkJCS8qCisJCQkgKiBEcm9wIHRoZSBiaW5kIHRvIHRoZSBwcm9ncmFt
IG9uY2UgaXQgaXMgZ29uZSBzbyB0aGUKKwkJCSAqIG1hcCBjYW4gYmUgcmV1c2VkLCBhbmQgY2xl
YXIgdGhlIHN0YWxlIGppdHRlZAorCQkJICogcG9pbnRlcnMgLyB4bGF0ZWQgb2Zmc2V0cyBzbyB0
aGV5IGRvIG5vdCBvdXRsaXZlCisJCQkgKiB0aGUgYm91bmQgcHJvZ3JhbS4KKwkJCSAqLworCQkJ
YnBmX2luc25fYXJyYXlfcmVsZWFzZShtYXApOwogCQlicGZfbWFwX3B1dChtYXApOwogCX0KIH0K
ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvZml4dXBzLmMgYi9rZXJuZWwvYnBmL2ZpeHVwcy5jCmlu
ZGV4IDY1YjQ0MWU0YTM1MS4uYzAxYjljMDg0YjU3IDEwMDY0NAotLS0gYS9rZXJuZWwvYnBmL2Zp
eHVwcy5jCisrKyBiL2tlcm5lbC9icGYvZml4dXBzLmMKQEAgLTUxNiw4ICs1MTYsMjUgQEAgc3Rh
dGljIGludCB2ZXJpZmllcl9yZW1vdmVfaW5zbnMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVu
diwgdTMyIG9mZiwgdTMyIGNudCkKIHsKIAlzdHJ1Y3QgYnBmX2luc25fYXV4X2RhdGEgKmF1eF9k
YXRhID0gZW52LT5pbnNuX2F1eF9kYXRhOwogCXVuc2lnbmVkIGludCBvcmlnX3Byb2dfbGVuID0g
ZW52LT5wcm9nLT5sZW47CisJdTMyIGk7CiAJaW50IGVycjsKIAorCS8qCisJICogSW5zdHJ1Y3Rp
b25zIHRoYXQgYXJlIHRhcmdldHMgb2YgdmVyaWZpZWQgaW5kaXJlY3QganVtcHMKKwkgKiAoaW5z
bl9hcnJheSAvIGdvdG94KSBtdXN0IG5ldmVyIGJlIHJlbW92ZWQ6IHRoZSBqdW1wIHRhYmxlIGlz
CisJICogdmVyaWZpZWQgYWdhaW5zdCB0aGVzZSB2ZXJ5IGluc3RydWN0aW9ucyBhbmQgdGhlIEpJ
VCBmaWxscyB0aGUKKwkgKiBqaXR0ZWQgcG9pbnRlcnMgaW50byB0aGUgdGFibGUuICBSZW1vdmlu
ZyBzdWNoIGFuIGluc3RydWN0aW9uCisJICogd291bGQgbGVhdmUgdGhlIGNvcnJlc3BvbmRpbmcg
dGFibGUgZW50cnkgZGFuZ2xpbmcgYW5kIHR1cm4gYQorCSAqIHZlcmlmaWVyLWFwcHJvdmVkIGBn
b3RveCByWGAgaW50byBhIGp1bXAgdGhyb3VnaCBhIE5VTEwgb3Igc3RhbGUKKwkgKiBjb2RlIHBv
aW50ZXIgYXQgcnVuIHRpbWUuCisJICovCisJZm9yIChpID0gb2ZmOyBpIDwgb2ZmICsgY250OyBp
KyspIHsKKwkJaWYgKGF1eF9kYXRhW2ldLmluZGlyZWN0X3RhcmdldCkgeworCQkJdmVyYm9zZShl
bnYsICJjYW5ub3QgcmVtb3ZlIGluc3RydWN0aW9uICV1OiBpbmRpcmVjdCBqdW1wIHRhcmdldFxu
IiwgaSk7CisJCQlyZXR1cm4gLUVGQVVMVDsKKwkJfQorCX0KKwogCWlmIChicGZfcHJvZ19pc19v
ZmZsb2FkZWQoZW52LT5wcm9nLT5hdXgpKQogCQlicGZfcHJvZ19vZmZsb2FkX3JlbW92ZV9pbnNu
cyhlbnYsIG9mZiwgY250KTsKIApAQCAtNjEzLDYgKzYzMCw3IEBAIGludCBicGZfb3B0X3JlbW92
ZV9kZWFkX2NvZGUoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudikKIAogaW50IGJwZl9vcHRf
cmVtb3ZlX25vcHMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudikKIHsKKwlzdHJ1Y3QgYnBm
X2luc25fYXV4X2RhdGEgKmF1eF9kYXRhID0gZW52LT5pbnNuX2F1eF9kYXRhOwogCXN0cnVjdCBi
cGZfaW5zbiAqaW5zbiA9IGVudi0+cHJvZy0+aW5zbnNpOwogCWludCBpbnNuX2NudCA9IGVudi0+
cHJvZy0+bGVuOwogCWJvb2wgaXNfbWF5X2dvdG9fMCwgaXNfamE7CkBAIC02MjIsNyArNjQwLDEy
IEBAIGludCBicGZfb3B0X3JlbW92ZV9ub3BzKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYp
CiAJCWlzX21heV9nb3RvXzAgPSAhbWVtY21wKCZpbnNuW2ldLCAmTUFZX0dPVE9fMCwgc2l6ZW9m
KE1BWV9HT1RPXzApKTsKIAkJaXNfamEgPSAhbWVtY21wKCZpbnNuW2ldLCAmTk9QLCBzaXplb2Yo
Tk9QKSk7CiAKLQkJaWYgKCFpc19tYXlfZ290b18wICYmICFpc19qYSkKKwkJLyogRG8gbm90IHJl
bW92ZSBpbmRpcmVjdCBqdW1wIHRhcmdldHM6IHRoZSBqdW1wIHRhYmxlIGVudHJpZXMKKwkJICog
Zm9yIHRoZW0gd2VyZSB2ZXJpZmllZCBhZ2FpbnN0IHRoZXNlIGluc3RydWN0aW9ucywgYW5kIHRo
ZQorCQkgKiByZW1vdmFsIHdvdWxkIGxlYXZlIHRoZSB0YWJsZSBlbnRyaWVzIGRhbmdsaW5nIChz
ZWUKKwkJICogdmVyaWZpZXJfcmVtb3ZlX2luc25zKCkpLgorCQkgKi8KKwkJaWYgKCghaXNfbWF5
X2dvdG9fMCAmJiAhaXNfamEpIHx8IGF1eF9kYXRhW2ldLmluZGlyZWN0X3RhcmdldCkKIAkJCWNv
bnRpbnVlOwogCiAJCWVyciA9IHZlcmlmaWVyX3JlbW92ZV9pbnNucyhlbnYsIGksIDEpOwotLSAK
Mi41NS4wCgo=
--00000000000067210a065aaabfbc--

