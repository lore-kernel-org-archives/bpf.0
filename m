Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05F2C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A845F21019
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Zdl7SO6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCNMjC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:39:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54990 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfCNMjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 08:39:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so2836705wmj.4
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UFA00KGdgfw4IY1PDenGZXbSDweTm6Rjxc3ZxwbZbo0=;
        b=Zdl7SO6FZUQFluonlFe/mFTGeYocPmBntwXjEkEI9M58Zmfouc+yWtXkotYTFvauMO
         wg4gP51Ghm04F4NYFxo4uDUJ954CaL9vlWlUsK6m3wsX64cUPDgSNm4NVYnTXUm3mc7a
         gKdNjQeEIjzuuWZr6mY9kiFaC4+fm87tSerGNkmoR29PcxsvdDTKmdxGulHg1Xgu4/Fi
         L+Uohx5UhSvycAAC2+F/3v9WIHujLu4TSOG9V34uKUWGWasCW+Z/zZwCY3DeL4YkrwIs
         qxEt8oN4O6RNgAf0aF6V12Uz0ypyk/Iv/SyY239gQYmg8Ov0bEyy4UDzrORrmW4q9iaq
         RgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UFA00KGdgfw4IY1PDenGZXbSDweTm6Rjxc3ZxwbZbo0=;
        b=PBTVwWsOLMCA3t0+LUaUV2NxX6FreWYrJDg+9LdqH3gJAI29CHKfgkvDEkHhRyPz+a
         4D2DCFZY2IeCVvnKybKThdAPRXZVbb7x7xpFNjmg5GVJ3lfuBA56ytgbPlayLLVEp78d
         qmKdKYwG5hrUqgB7NAKmxt99uDwen2HN7/H+Obtkd4McB9tIT3HDXr8oBo13xEvqJaPs
         lUqXEXtwiUJMAN+PiDIfcoJaOCW4MmNPmkuHLy2YrOmd+6Q7RjcDaQt6OsXS95vu/Nsf
         KYfU/sXiA+mY3XDuCbGzwhTnwz/R3ThZgca69wxsZ2o0u/MjdgUKJN8FbjAOzRGxz8/q
         n9wA==
X-Gm-Message-State: APjAAAXcBd3mniOuH2lywClKYg5F1NIMLMdNuXzcagOrQyZnRoD42x4W
        u5M9VbfpLnwR3gnzxbntgTwsag==
X-Google-Smtp-Source: APXvYqx3o+xvctQW/VgIG6wIdmmmgi5SK1bYhNOLuKSxARsXiM4OaXZnAnEo7uyFzMA/SdewyoEwZw==
X-Received: by 2002:a1c:2d4c:: with SMTP id t73mr2415518wmt.142.1552567138018;
        Thu, 14 Mar 2019 05:38:58 -0700 (PDT)
Received: from reblochon.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id u8sm2285569wml.22.2019.03.14.05.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:38:57 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 3/3] tools: bpf: synchronise BPF UAPI header with tools
Date:   Thu, 14 Mar 2019 12:38:41 +0000
Message-Id: <20190314123841.13092-4-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190314123841.13092-1-quentin.monnet@netronome.com>
References: <20190314123841.13092-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Synchronise the bpf.h header under tools, to report the latest fixes and
additions to the documentation for the BPF helpers.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/include/uapi/linux/bpf.h | 183 +++++++++++++++++++++++++++--------------
 1 file changed, 120 insertions(+), 63 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 983b25cb608d..929c8e537a14 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -502,16 +502,6 @@ union bpf_attr {
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
- * int bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
- * 	Description
- * 		Push an element *value* in *map*. *flags* is one of:
- *
- * 		**BPF_EXIST**
- * 		If the queue/stack is full, the oldest element is removed to
- * 		make room for this.
- * 	Return
- * 		0 on success, or a negative error in case of failure.
- *
  * int bpf_probe_read(void *dst, u32 size, const void *src)
  * 	Description
  * 		For tracing programs, safely attempt to read *size* bytes from
@@ -1435,14 +1425,14 @@ union bpf_attr {
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
- * 		*skb*, but gets socket from **struct bpf_sock_addr** contex.
+ * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
  * 		A 8-byte long non-decreasing number.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
- * 		*skb*, but gets socket from **struct bpf_sock_ops** contex.
+ * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
  * 		A 8-byte long non-decreasing number.
  *
@@ -2098,52 +2088,52 @@ union bpf_attr {
  *	Return
  * 		0 on success, or a negative error in case of failure.
  *
- * int bpf_rc_keydown(void *ctx, u32 protocol, u64 scancode, u32 toggle)
+ * int bpf_rc_repeat(void *ctx)
  *	Description
  *		This helper is used in programs implementing IR decoding, to
- *		report a successfully decoded key press with *scancode*,
- *		*toggle* value in the given *protocol*. The scancode will be
- *		translated to a keycode using the rc keymap, and reported as
- *		an input key down event. After a period a key up event is
- *		generated. This period can be extended by calling either
- *		**bpf_rc_keydown**\ () again with the same values, or calling
- *		**bpf_rc_repeat**\ ().
+ *		report a successfully decoded repeat key message. This delays
+ *		the generation of a key up event for previously generated
+ *		key down event.
  *
- *		Some protocols include a toggle bit, in case the button	was
- *		released and pressed again between consecutive scancodes.
+ *		Some IR protocols like NEC have a special IR message for
+ *		repeating last button, for when a button is held down.
  *
  *		The *ctx* should point to the lirc sample as passed into
  *		the program.
  *
- *		The *protocol* is the decoded protocol number (see
- *		**enum rc_proto** for some predefined values).
- *
  *		This helper is only available is the kernel was compiled with
  *		the **CONFIG_BPF_LIRC_MODE2** configuration option set to
  *		"**y**".
  *	Return
  *		0
  *
- * int bpf_rc_repeat(void *ctx)
+ * int bpf_rc_keydown(void *ctx, u32 protocol, u64 scancode, u32 toggle)
  *	Description
  *		This helper is used in programs implementing IR decoding, to
- *		report a successfully decoded repeat key message. This delays
- *		the generation of a key up event for previously generated
- *		key down event.
+ *		report a successfully decoded key press with *scancode*,
+ *		*toggle* value in the given *protocol*. The scancode will be
+ *		translated to a keycode using the rc keymap, and reported as
+ *		an input key down event. After a period a key up event is
+ *		generated. This period can be extended by calling either
+ *		**bpf_rc_keydown**\ () again with the same values, or calling
+ *		**bpf_rc_repeat**\ ().
  *
- *		Some IR protocols like NEC have a special IR message for
- *		repeating last button, for when a button is held down.
+ *		Some protocols include a toggle bit, in case the button	was
+ *		released and pressed again between consecutive scancodes.
  *
  *		The *ctx* should point to the lirc sample as passed into
  *		the program.
  *
+ *		The *protocol* is the decoded protocol number (see
+ *		**enum rc_proto** for some predefined values).
+ *
  *		This helper is only available is the kernel was compiled with
  *		the **CONFIG_BPF_LIRC_MODE2** configuration option set to
  *		"**y**".
  *	Return
  *		0
  *
- * uint64_t bpf_skb_cgroup_id(struct sk_buff *skb)
+ * u64 bpf_skb_cgroup_id(struct sk_buff *skb)
  * 	Description
  * 		Return the cgroup v2 id of the socket associated with the *skb*.
  * 		This is roughly similar to the **bpf_get_cgroup_classid**\ ()
@@ -2159,30 +2149,12 @@ union bpf_attr {
  * 	Return
  * 		The id is returned or 0 in case the id could not be retrieved.
  *
- * u64 bpf_skb_ancestor_cgroup_id(struct sk_buff *skb, int ancestor_level)
- *	Description
- *		Return id of cgroup v2 that is ancestor of cgroup associated
- *		with the *skb* at the *ancestor_level*.  The root cgroup is at
- *		*ancestor_level* zero and each step down the hierarchy
- *		increments the level. If *ancestor_level* == level of cgroup
- *		associated with *skb*, then return value will be same as that
- *		of **bpf_skb_cgroup_id**\ ().
- *
- *		The helper is useful to implement policies based on cgroups
- *		that are upper in hierarchy than immediate cgroup associated
- *		with *skb*.
- *
- *		The format of returned id and helper limitations are same as in
- *		**bpf_skb_cgroup_id**\ ().
- *	Return
- *		The id is returned or 0 in case the id could not be retrieved.
- *
  * u64 bpf_get_current_cgroup_id(void)
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
  *
- * void* get_local_storage(void *map, u64 flags)
+ * void *bpf_get_local_storage(void *map, u64 flags)
  *	Description
  *		Get the pointer to the local storage area.
  *		The type and the size of the local storage is defined
@@ -2209,6 +2181,24 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
+ * u64 bpf_skb_ancestor_cgroup_id(struct sk_buff *skb, int ancestor_level)
+ *	Description
+ *		Return id of cgroup v2 that is ancestor of cgroup associated
+ *		with the *skb* at the *ancestor_level*.  The root cgroup is at
+ *		*ancestor_level* zero and each step down the hierarchy
+ *		increments the level. If *ancestor_level* == level of cgroup
+ *		associated with *skb*, then return value will be same as that
+ *		of **bpf_skb_cgroup_id**\ ().
+ *
+ *		The helper is useful to implement policies based on cgroups
+ *		that are upper in hierarchy than immediate cgroup associated
+ *		with *skb*.
+ *
+ *		The format of returned id and helper limitations are same as in
+ *		**bpf_skb_cgroup_id**\ ().
+ *	Return
+ *		The id is returned or 0 in case the id could not be retrieved.
+ *
  * struct bpf_sock *bpf_sk_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
  *	Description
  *		Look for TCP socket matching *tuple*, optionally in a child
@@ -2289,6 +2279,16 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
+ * int bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
+ * 	Description
+ * 		Push an element *value* in *map*. *flags* is one of:
+ *
+ * 		**BPF_EXIST**
+ * 			If the queue/stack is full, the oldest element is
+ * 			removed to make room for this.
+ * 	Return
+ * 		0 on success, or a negative error in case of failure.
+ *
  * int bpf_map_pop_elem(struct bpf_map *map, void *value)
  * 	Description
  * 		Pop an element from *map*.
@@ -2343,36 +2343,93 @@ union bpf_attr {
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
- *		that all the fields in bpf_sock can be accessed.
+ *		that all the fields in this **bpf_sock** can be accessed.
  *	Return
- *		A **struct bpf_sock** pointer on success, or NULL in
+ *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
  *
  * struct bpf_tcp_sock *bpf_tcp_sock(struct bpf_sock *sk)
  *	Description
  *		This helper gets a **struct bpf_tcp_sock** pointer from a
  *		**struct bpf_sock** pointer.
- *
  *	Return
- *		A **struct bpf_tcp_sock** pointer on success, or NULL in
+ *		A **struct bpf_tcp_sock** pointer on success, or **NULL** in
  *		case of failure.
  *
  * int bpf_skb_ecn_set_ce(struct sk_buf *skb)
- *     Description
- *             Sets ECN of IP header to ce (congestion encountered) if
- *             current value is ect (ECN capable). Works with IPv6 and IPv4.
- *     Return
- *             1 if set, 0 if not set.
+ *	Description
+ *		Set ECN (Explicit Congestion Notification) field of IP header
+ *		to **CE** (Congestion Encountered) if current value is **ECT**
+ *		(ECN Capable Transport). Otherwise, do nothing. Works with IPv6
+ *		and IPv4.
+ *	Return
+ *		1 if the **CE** flag is set (either by the current helper call
+ *		or because it was already present), 0 if it is not set.
  *
  * struct bpf_sock *bpf_get_listener_sock(struct bpf_sock *sk)
  *	Description
- *		Return a **struct bpf_sock** pointer in TCP_LISTEN state.
- *		bpf_sk_release() is unnecessary and not allowed.
+ *		Return a **struct bpf_sock** pointer in **TCP_LISTEN** state.
+ *		**bpf_sk_release**\ () is unnecessary and not allowed.
  *	Return
- *		A **struct bpf_sock** pointer on success, or NULL in
+ *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
-- 
2.14.1

