Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069282;
	b=QwUvp00WU6HcDeXGAIJn4EbolaeTyD66RxTpIOR7VzIC3X61j573CypR1jKgRpoH3PGa
	 Hhrv8WboTDImQjMnL1mdFPp17UCDgI/Fbh2tnbNsNshkey417a3Bvr1zL+pRcepy8VNmQ
	 ETXG51g4YSJ+kVUK9DkPTzoLD5fEVvj7cz9msobsGrbnxjky7r/W8UUDGT8Xc7gNM/5lD
	 a/m+52Sql7aQnpKWKiVgxn2kv5urkHQRkkWdccyWe+murQz7BZzABed31FsBlIFNQJCWy
	 nwxDgi8JpiEHimXjWMm/LLaHNCjEtJhl4YGq85dp5vwGsgEqmkJToBn/4PUOb7SHxIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
	b=HhXWC87Dn49DK+IuPxiKhn2VIKd8lPaKcF/34kmijAvXWDcnGltg+EtczbsaB3hRtlNf
	 Q+ZtEPGos17tdr5IqrBTqcbQEJN22ekxFotJB8X7/WjLxO0XAHOCxq2XPTff+ajYaTJqB
	 BcVtcTz/NPDRXKeVeaKsss2Noi1a2WT3MwjvC2lC2aaOU/wzSFvhflxOvClBhDIaLwz7z
	 jNPm//8MTXUJCBJv1NUB04DelRogr2JQXoiGUmyJSRpwvumm3AcgwYoSL0yWd9sBlNTLv
	 ITpjHp3I4GmS3bqmz5eQ0fqd2lNk4V9oWdN+oAQGfyAM3TR6f49ZYZ7cNxU2Q8v3+6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc2q2E6a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAB606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FAAB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc2q2E6a
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-92107df3f13so17019786d6.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069281; cv=none;
        d=google.com; s=arc-20260327;
        b=InApL18D5R6aEgCIrN2x215052cDdMZVFeECJhYol1zwXoUwm+CxDvcio/0vt4+5rV
         O1FQanae20DBWoolrNqIs/jpASSVrTiNuRK8RYClAEkBIYTXwe7mPa962TJszLxYOoJc
         gIl2OCFHtg7qzzXrzHAQo+bOTLlPv7mt9Odb6r28yYZD233mL148WluqKl2WdEl+/TYA
         22sb7I3l/bsBnBD/RVkn/hdukFpeoNB7GSaZw9XBLs1AaGQnzfgnaN4ZUKVsdrErU02s
         Nxm9rdYgd2lMANQqwTrvLWzpaSxnj26Hkl4lTQV1RCCigQwxqRGVKo3iHKDE+yXtFGcO
         sE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        fh=cJ+rkCCzjmiIdjfYYl4ktk0CFh5MvFmsZCTazJNv5xM=;
        b=qyWN1qKoaHZj3wmRYqrq5bd7Daz/I9kQWn1CF323pPBrGpSfNP77ZKGRjKfbXbBe5p
         D+FpGlKzQzrRPHQI8UC/JRNgyBOYFX/G7ODhR/XaVBHps85IBh0MZgnb3usoLUnqUsNg
         aqPAD5LgowdFh0fS3cOCGRzlUIzSz2II03fRiE3Jsmp022lpjrubTeNFeTbigg796B8v
         z+3uQO9LOontaCucMmU6cTxOiQdpKWTiJNSzPvomJQtZyuDVOb5b2xnqNCDBtQ3MYKB7
         62KumuuDqivN4Znna2vjpppurVG9V7jYa9jivC7z9EcEHBwopo3pzvH2WTwtpVSoRINS
         zkEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069281; x=1795674081; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=Lc2q2E6aq/619ivYO6N3rLuPF4GGpBYfUThFCLnXePbxSRg8VO6GmEpvXmwK3IB1H0
         EdQBzDmWmk0W+i06F7oQcBQUc6Nb9R6sf9NyPovrLi7PJpo59YUGRLnVoEiFmfDJE1eD
         znQZ94clOnQt09sBYjkAIKoibCtHSbm8FORWqeiPBdy7b2aYJ4rtVxT38BnMiZTJyE61
         ECcuTdghI2R9+T9DjSqp7TJwiuyy7cZECFRYrX3L0CEXZ80DgSCd0Da9i5dezHKbAK9m
         Sy9he5BQ5mpF68GITpvRHpHeQ3NJKgQhdy8iqXgtKdaGScMFryzv0jux06v6A8AfLEW7
         StmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069281; x=1795674081;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=FJZwGjfLKXzSmEd2r4tgSARm5JudwAufyglKY6n1XId8lXJeyrsFF92srlByHt4XxJ
         u36q4NAlG5QH5xxXlcEj/zlqS+MbRrKQBtDwStt7T3t9X4deyb9IsNofRuuMqaTmxz2p
         oZnvtH+yggyP9iTjXZbHhgW30NLXwZ4mLvYKmn13Mbqeu8UqNhK4YoX+Nu3oWdkZeOyP
         QiuV+NjnuiCIXD0KlHSC3Vnw7GkLeHY1Wuv5LeyMf6wB9+xA+8i+4baMcujWHHwDDWLq
         MkXsc2HInYXmP1gN84OFDFgFpT23np2Oulaxi7QQG1kRmOka8HIryvInm4XR/zj2sWOA
         kpzw==
X-Gm-Message-State: APuU4Z/bFZNwn6Aunug4OsVeSA8xeBSHVIsXKELgw8OA08xWXD3RK+C4
	LN8wwke/Y9A+Ll1wI4Y7t4VF08+gxcnJnPVxfq+HU5OH/dz/bQxJIl3OYGBqSD2OqdF0pURJ/Uf
	N3TIFK0ELJ5UtuEKc8Pz2KQj4JOUUK9sTnMbrXWa3Avpx
X-Gm-Gg: AZFdTZcYp60bzOXBzUWLAlpBamAhiIPo8EmyoPNH5EoohduFsryxVDUgp+gec2N89Zm
	n9jnXxBF2FQTJGHnWlxP3m0OHL0BdLDHqfq1rb/S7mCsNoxikSoJ7NsKUjKQLwnqnVYCjwTNBXJ
	WSwUpPYZDJ53Z/jiwns+Wtmn6IEAe6hPfJEBeIt9y2w1o9frbWY76vkmIZTsag8xxPzOWVRrike
	+jDkUdP4yRLbh/QskC2V4MlMueutARt3eRP/Cy4OJWKjD9E+NZk40MEX9ruhpXflBozgb2I3Cpe
	6LDb1lQTccl7aEkmota/eHmsmmaydxwyTloipfhUUGZepQ/790/RjZxQhYdgujL6EBLpOMu54Hx
	Bi0S5EJnMxL47Nho9BWHfo8ASXC2H7b9OaLTcr4k16wKrYouYQs36nTLJqQaDwN8rgS+g/MyCGu
	9WlGpISoDmdxPZwSxdpYs=
X-Received: by 2002:a05:6214:8602:b0:921:117d:2e88 with SMTP id
 6a1803df08f44-92114f1258fmr78619116d6.28.1795069280925; Wed, 18 Nov 2026
 22:21:20 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:21:09 -0500
X-Gm-Features: Aa3M54rKctNstj-xAw2aIWk4fNeHbccByvy8aMtrRliTYHyg6gQPWk7NFTjZLmk
Message-ID: <CAMcAce918POMDvZtF6QbhZMzmf+m49jKGdBEKV2pUi_Y3nn-Ug@mail.gmail.com>
Subject: [PATCH bpf 3/3] bpf: Add missing raw_tp_null_args[] entries for fs tracepoints
To: bpf@vger.kernel.org
Cc: dsterba@suse.com, dhowells@redhat.com, pc@manguebit.org, 
	idryomov@gmail.com, linux-btrfs@vger.kernel.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Four built-in filesystem tracepoints pass NULL pointer arguments without
corresponding PTR_MAYBE_NULL masks in raw_tp_null_args[]:

  1. btrfs_prelim_ref_insert (include/trace/events/btrfs.h:2878):
     fs/btrfs/backref.c:328 passes literal NULL for arg 2 (newref),
     and TP_fast_assign (:2856) checks newref ? newref->count : 0.
     Add { "btrfs_prelim_ref_insert", 0x100 }. (Also affects 6.12.y.)

  2. cachefiles_no_space (include/trace/events/cachefiles.h:718):
     fs/cachefiles/namei.c:122 passes literal NULL for arg 0 (obj),
     and TP_fast_assign (:729) checks obj ? obj->debug_id : 0.
     Add { "cachefiles_no_space", 0x1 }.

  3. netfs_failure (include/trace/events/netfs.h:413):
     raw_tp_null_args[] currently lists 0x10 (arg 1, sreq only), while
     fs/netfs/buffered_read.c:790 calls trace_netfs_failure(NULL, NULL,
     ret, netfs_fail_check_write_begin), passing literal NULL for arg 0
     (rreq) as well. Update mask to 0x11. (Also affects 6.12.y.)

  4. ceph_mdsc_suspend_request (include/trace/events/ceph.h:89):
     fs/ceph/mds_client.c:3691,3726,3749 invoke
     trace_ceph_mdsc_suspend_request(mdsc, session, req, ...) with
     session == NULL (arg 1), and TP_fast_assign (:107) checks
     session ? session->s_mds : -1. Add { "ceph_mdsc_suspend_request", 0x10 }.

Verified in QEMU on x86_64 7.4.0-rc3 (20eef29b7c84, all 4 tracepoints
flip LOADED -> REJECTED) and 6.12.118 (btrfs_prelim_ref_insert and
netfs_failure flip LOADED -> REJECTED; cachefiles_no_space and
ceph_mdsc_suspend_request are post-6.12 tracepoints).

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef10af2..30be05b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7274,6 +7274,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "afs_make_fs_call2", 0x10 },
  { "afs_protocol_error", 0x1 },
  { "afs_flock_ev", 0x10 },
+ /* btrfs */
+ { "btrfs_prelim_ref_insert", 0x100 },
  /* cachefiles */
  { "cachefiles_lookup", 0x1 | 0x200 },
  { "cachefiles_unlink", 0x1 },
@@ -7284,6 +7286,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "cachefiles_mark_inactive", 0x1 },
  { "cachefiles_vfs_error", 0x1 },
  { "cachefiles_io_error", 0x1 },
+ { "cachefiles_no_space", 0x1 },
  /* ext4, from ext4__mballoc event class */
  { "ext4_mballoc_discard", 0x10 },
  { "ext4_mballoc_free", 0x10 },
@@ -7314,7 +7317,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  /* .. from mm_page event class */
  { "mm_page_alloc_zone_locked", 0x1 },
  /* netfs */
- { "netfs_failure", 0x10 },
+ { "netfs_failure", 0x11 },
  /* power */
  { "device_pm_callback_start", 0x10 },
  /* qdisc */
@@ -7416,6 +7419,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "pnfs_mds_fallback_write_done", 0x10000 },
  { "pnfs_mds_fallback_read_pagelist", 0x10000 },
  { "pnfs_mds_fallback_write_pagelist", 0x10000 },
+ /* ceph */
+ { "ceph_mdsc_suspend_request", 0x10 },
  /* coda */
  { "coda_dec_pic_run", 0x10 },
  { "coda_dec_pic_done", 0x10 },
