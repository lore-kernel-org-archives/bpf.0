Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6B6C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB5F21019
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Mzwb0K+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCNMi7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:38:59 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50911 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfCNMi6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 08:38:58 -0400
Received: by mail-wm1-f52.google.com with SMTP id x7so2819745wmj.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u02bxxll85EHUPBxk65Wr75o99hxDCX2L9TiBAgrHUY=;
        b=Mzwb0K+W4uCsvrexrW7rgQtghLHfQyuy7Z/OqgCr3/EQOMUvGtg3b7mDEUTiSb/Sjf
         ovWv2q64tUJWmsHOG5lIUnesA67uny8fsEKToM2GFSj41xSK15PL7k2gPqmNG8LFjZRa
         kUIndMecCbSXRkielE507jXo4PU710GfHsR0RMXNXqIHLYQnwxdVxIZVwF5q8xa42Adi
         opn7E46ZYnzTaBdsouAk2r+oppy0njTlgod+8sv/3z4iikvS+ZD7Ihf+vYhqyjgRvOfq
         RmHHppqQR66uOAeyn9UNE5hPA5vZYBJn4Dq59AdTX2eIKTSOCKiYfcBJf+DaScfL9A+8
         vt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u02bxxll85EHUPBxk65Wr75o99hxDCX2L9TiBAgrHUY=;
        b=JSIkIFikfBLItt5e1xoR8N/V0yHorsJPwDq4/24OzE6cL2SZS5Oo9f+ig4P3yvIy++
         mHuKCV+NnXIKTqr8pDGnjujVtCc4N1+njqSzxN6WWPm0fBIcvzltFeWVk6LB0loYo/5L
         JAu+S03wVAT50jQRv/os/ccRqKPAyxiKEUG10nqpttN4Jtalujo0i1rnOS7l8ZdzpWfp
         c7hp+zRTxflLxmZJG1FBEKGzQHljdGl2gfxR6EGTbvl98v/04qBaL3orQnARWwveoF1S
         rLtOi83ONv8NAOjN6Xst6h2MzrvEGBYrMZwj60o5VtKyKKU+bZBqsIdOxMa4N3VeQoOk
         riIg==
X-Gm-Message-State: APjAAAUmo9/nQ7d6DM8z8bCR+h1InaiZtLQ+QxqSjxgG++L/er9jop1U
        20//0KWX+IXN2bUvtGWHZcHKFA==
X-Google-Smtp-Source: APXvYqxYYuc29msep+ZDX4fcoTmSOhy8lsGUdWNaGLNdgK4nFgKeIWH7P3A60fK5yQs6w7qnk38IoQ==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr2597276wmb.10.1552567136303;
        Thu, 14 Mar 2019 05:38:56 -0700 (PDT)
Received: from reblochon.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id u8sm2285569wml.22.2019.03.14.05.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:38:55 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 2/3] bpf: add documentation for helpers bpf_spin_lock(), bpf_spin_unlock()
Date:   Thu, 14 Mar 2019 12:38:40 +0000
Message-Id: <20190314123841.13092-3-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190314123841.13092-1-quentin.monnet@netronome.com>
References: <20190314123841.13092-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add documentation for the BPF spinlock-related helpers to the doc in
bpf.h. I added the constraints and restrictions coming with the use of
spinlocks for BPF: not all of it is directly related to the use of the
helper, but I thought it would be nice for users to find them in the man
page.

This list of restrictions is nearly a verbatim copy of the list in
Alexei's commit log for those helpers.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/uapi/linux/bpf.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4465d00d3493..929c8e537a14 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2343,6 +2343,61 @@ union bpf_attr {
  *	Return
  *		0
  *
+ * int bpf_spin_lock(struct bpf_spin_lock *lock)
+ *	Description
+ *		Acquire a spinlock represented by the pointer *lock*, which is
+ *		stored as part of a value of a map. Taking the lock allows to
+ *		safely update the rest of the fields in that value. The
+ *		spinlock can (and must) later be released with a call to
+ *		**bpf_spin_unlock**\ (\ *lock*\ ).
+ *
+ *		Spinlocks in BPF programs come with a number of restrictions
+ *		and constraints:
+ *
+ *		* **bpf_spin_lock** objects are only allowed inside maps of
+ *		  types **BPF_MAP_TYPE_HASH** and **BPF_MAP_TYPE_ARRAY** (this
+ *		  list could be extended in the future).
+ *		* BTF description of the map is mandatory.
+ *		* The BPF program can take ONE lock at a time, since taking two
+ *		  or more could cause dead locks.
+ *		* Only one **struct bpf_spin_lock** is allowed per map element.
+ *		* When the lock is taken, calls (either BPF to BPF or helpers)
+ *		  are not allowed.
+ *		* The **BPF_LD_ABS** and **BPF_LD_IND** instructions are not
+ *		  allowed inside a spinlock-ed region.
+ *		* The BPF program MUST call **bpf_spin_unlock**\ () to release
+ *		  the lock, on all execution paths, before it returns.
+ *		* The BPF program can access **struct bpf_spin_lock** only via
+ *		  the **bpf_spin_lock**\ () and **bpf_spin_unlock**\ ()
+ *		  helpers. Loading or storing data into the **struct
+ *		  bpf_spin_lock** *lock*\ **;** field of a map is not allowed.
+ *		* To use the **bpf_spin_lock**\ () helper, the BTF description
+ *		  of the map value must be a struct and have **struct
+ *		  bpf_spin_lock** *anyname*\ **;** field at the top level.
+ *		  Nested lock inside another struct is not allowed.
+ *		* The **struct bpf_spin_lock** *lock* field in a map value must
+ *		  be aligned on a multiple of 4 bytes in that value.
+ *		* Syscall with command **BPF_MAP_LOOKUP_ELEM** does not copy
+ *		  the **bpf_spin_lock** field to user space.
+ *		* Syscall with command **BPF_MAP_UPDATE_ELEM**, or update from
+ *		  a BPF program, do not update the **bpf_spin_lock** field.
+ *		* **bpf_spin_lock** cannot be on the stack or inside a
+ *		  networking packet (it can only be inside of a map values).
+ *		* **bpf_spin_lock** is available to root only.
+ *		* Tracing programs and socket filter programs cannot use
+ *		  **bpf_spin_lock**\ () due to insufficient preemption checks
+ *		  (but this may change in the future).
+ *		* **bpf_spin_lock** is not allowed in inner maps of map-in-map.
+ *	Return
+ *		0
+ *
+ * int bpf_spin_unlock(struct bpf_spin_lock *lock)
+ *	Description
+ *		Release the *lock* previously locked by a call to
+ *		**bpf_spin_lock**\ (\ *lock*\ ).
+ *	Return
+ *		0
+ *
  * struct bpf_sock *bpf_sk_fullsock(struct bpf_sock *sk)
  *	Description
  *		This helper gets a **struct bpf_sock** pointer such
-- 
2.14.1

