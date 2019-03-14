Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F077C10F06
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2504A2184C
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 12:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DI4Wl5V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCNMi7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:38:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53697 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCNMi6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 08:38:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so2788880wmg.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7DgF5I6ZVKZkBYLUY17mpmD1boQqv9DtD//RUjM4nic=;
        b=DI4Wl5V4uHARy+UiT1kkvJ7hYXIFn9fpkSK8GVV1ePp4wvxGNTaRHjgTZcTymYeevG
         rCY/B8cLx5OMk1BHTKplwQroCS0oFf9ND8bq7//o6nvr+8Azl8rMiPY/uEI9opFw5SpQ
         yRbP19Sb5cFWwqKwabyqU0aSVmM/tthexCaa4exOmdTojxvw2CxWo+ArJbIAhoadQsMS
         NOv+bhhzGhhzTzOhKHV4TLYkwxgmCG4ODgqgCPwqeDoafYjqpCU3OH8t/wZgHSrHZUpM
         dqH4nHfwv1XEKLie8l6YBscrDNVhSv+dTDkywkpMOP9Bdiw0Ye9fbKyZHLE1QTpeiA15
         i0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7DgF5I6ZVKZkBYLUY17mpmD1boQqv9DtD//RUjM4nic=;
        b=FsMPRMEL5lRQhLf92jHnTGhFpeapuSfYRz3kkdhsdfPnbM/qld33qels2tJmGyx07S
         9IeQfnD2G/yiF6Z6TwS/DYD1LQdEwuDoJRiPl6awr1j4JnCNdhMW6Ym4tPbhzwl5r2g+
         OIQkFr91K9qZ/Oc9dhZOaPF1mku613h1XblLHk+0nRwx1tZmE50SsJPqWiG5xalGMYve
         qIJOd9VbPbYTyxcdhDxxcst113V7v0CfO4oq3UA9WQdlurUqVj8K/nkY0FRHe3WHq3QZ
         gsPRYY27jWFGcxzh8ejQBDpS8hL03VLnYUDN/tg/C7YM5s9lBy1ZrFeYIOEPBQGSE07P
         D0aQ==
X-Gm-Message-State: APjAAAU35nhSnUaNWUv0on+Nx2Vjzo72K/sn+UO6Pcayoaboy2ObY51T
        oQ5N8xbLAMAgB4KxALAxqZom8w==
X-Google-Smtp-Source: APXvYqzH5C/Xva78iu5DEbtG21tcdxGcQm0vsbBeepivvD8YQTP7/GpUVxTcjDeAHWCHIbfHoIzpRQ==
X-Received: by 2002:a1c:27c4:: with SMTP id n187mr2430100wmn.23.1552567135543;
        Thu, 14 Mar 2019 05:38:55 -0700 (PDT)
Received: from reblochon.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id u8sm2285569wml.22.2019.03.14.05.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:38:54 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 1/3] bpf: fix documentation for eBPF helpers
Date:   Thu, 14 Mar 2019 12:38:39 +0000
Message-Id: <20190314123841.13092-2-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190314123841.13092-1-quentin.monnet@netronome.com>
References: <20190314123841.13092-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Another round of minor fixes for the documentation of the BPF helpers
located in the UAPI bpf.h header file. Changes include:

- Moving around description of some helpers, to keep the descriptions in
  the same order as helpers are declared (bpf_map_push_elem(), leftover
  from commit 90b1023f68c7 ("bpf: fix documentation for eBPF helpers"),
  bpf_rc_keydown(), and bpf_skb_ancestor_cgroup_id()).
- Fixing typos ("contex" -> "context").
- Harmonising return types ("void* " -> "void *", "uint64_t" -> "u64").
- Addition of the "bpf_" prefix to bpf_get_storage().
- Light additions of RST markup on some keywords.
- Empty line deletion between description and return value for
  bpf_tcp_sock().
- Edit for the description for bpf_skb_ecn_set_ce() (capital letters,
  acronym expansion, no effect if ECT not set, more details on return
  value).

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/uapi/linux/bpf.h | 128 ++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 63 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 983b25cb608d..4465d00d3493 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
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
@@ -2346,33 +2346,35 @@ union bpf_attr {
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

