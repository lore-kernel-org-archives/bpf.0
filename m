Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C1C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB702206C1
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YPajtkIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfDZXjs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:39:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53722 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727131AbfDZXjr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 19:39:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3QNYGMJ016454
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=YWE2b4D1juf63bahUUXUxuFFEVB+RuXQABy9i6mS9Uk=;
 b=YPajtkIHi447f6lRjjw/ZtMcucugEKbget0BZeJZquXjwj8ES0RJi2AjnDcGnCrtVj0r
 tlnXbb/hRrgsz0kvmvKG6+oCWbay8A4hiFX5ypqA4xwL1sSwTXdPZhbstJr49kD1++1O
 ml3ROtgCSIgMUrwopOOkU5n6Jur61TAmHks= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2s44jgsf10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:42 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 26 Apr 2019 16:39:41 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 10E8B29425A9; Fri, 26 Apr 2019 16:39:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 1/7] bpf: Introduce bpf sk local storage
Date:   Fri, 26 Apr 2019 16:39:39 -0700
Message-ID: <20190426233939.1330422-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426233938.1330361-1-kafai@fb.com>
References: <20190426233938.1330361-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After allowing a bpf prog to
- directly read the skb->sk ptr
- get the fullsock bpf_sock by "bpf_sk_fullsock()"
- get the bpf_tcp_sock by "bpf_tcp_sock()"
- get the listener sock by "bpf_get_listener_sock()"
- avoid duplicating the fields of "(bpf_)sock" and "(bpf_)tcp_sock"
  into different bpf running context.

this patch is another effort to make bpf's network programming
more intuitive to do (together with memory and performance benefit).

When bpf prog needs to store data for a sk, the current practice is to
define a map with the usual 4-tuples (src/dst ip/port) as the key.
If multiple bpf progs require to store different sk data, multiple maps
have to be defined.  Hence, wasting memory to store the duplicated
keys (i.e. 4 tuples here) in each of the bpf map.
[ The smallest key could be the sk pointer itself which requires
  some enhancement in the verifier and it is a separate topic. ]

Also, the bpf prog needs to clean up the elem when sk is freed.
Otherwise, the bpf map will become full and un-usable quickly.
The sk-free tracking currently could be done during sk state
transition (e.g. BPF_SOCK_OPS_STATE_CB).

The size of the map needs to be predefined which then usually ended-up
with an over-provisioned map in production.  Even the map was re-sizable,
while the sk naturally come and go away already, this potential re-size
operation is arguably redundant if the data can be directly connected
to the sk itself instead of proxy-ing through a bpf map.

This patch introduces sk->sk_bpf_storage to provide local storage space
at sk for bpf prog to use.  The space will be allocated when the first bp=
f
prog has created data for this particular sk.

The design optimizes the bpf prog's lookup (and then optionally followed =
by
an inline update).  bpf_spin_lock should be used if the inline update nee=
ds
to be protected.

BPF_MAP_TYPE_SK_STORAGE:
-----------------------
To define a bpf "sk-local-storage", a BPF_MAP_TYPE_SK_STORAGE map (new in
this patch) needs to be created.  Multiple BPF_MAP_TYPE_SK_STORAGE maps c=
an
be created to fit different bpf progs' needs.  The map enforces
BTF to allow printing the sk-local-storage during a system-wise
sk dump (e.g. "ss -ta") in the future.

The purpose of a BPF_MAP_TYPE_SK_STORAGE map is not for lookup/update/del=
ete
a "sk-local-storage" data from a particular sk.
Think of the map as a meta-data (or "type") of a "sk-local-storage".  Thi=
s
particular "type" of "sk-local-storage" data can then be stored in any sk=
.

The main purposes of this map are mostly:
1. Define the size of a "sk-local-storage" type.
2. Provide a similar syscall userspace API as the map (e.g. lookup/update=
,
   map-id, map-btf...etc.)
3. Keep track of all sk's storages of this "type" and clean them up
   when the map is freed.

sk->sk_bpf_storage:
------------------
The main lookup/update/delete is done on sk->sk_bpf_storage (which
is a "struct bpf_sk_storage").  When doing a lookup,
the "map" pointer is now used as the "key" to search on the
sk_storage->list.  The "map" pointer is actually serving
as the "type" of the "sk-local-storage" that is being
requested.

To allow very fast lookup, it should be as fast as looking up an
array at a stable-offset.  At the same time, it is not ideal to
set a hard limit on the number of sk-local-storage "type" that the
system can have.  Hence, this patch takes a cache approach.
The last search result from sk_storage->list is cached in
sk_storage->cache[] which is a stable sized array.  Each
"sk-local-storage" type has a stable offset to the cache[] array.
In the future, a map's flag could be introduced to do cache
opt-out/enforcement if it became necessary.

The cache size is 16 (i.e. 16 types of "sk-local-storage").
Programs can share map.  On the program side, having a few bpf_progs
running in the networking hotpath is already a lot.  The bpf_prog
should have already consolidated the existing sock-key-ed map usage
to minimize the map lookup penalty.  16 has enough runway to grow.

All sk-local-storage data will be removed from sk->sk_bpf_storage
during sk destruction.

bpf_sk_storage_get() and bpf_sk_storage_delete():
------------------------------------------------
Instead of using bpf_map_(lookup|update|delete)_elem(),
the bpf prog needs to use the new helper bpf_sk_storage_get() and
bpf_sk_storage_delete().  The verifier can then enforce the
ARG_PTR_TO_SOCKET argument.  The bpf_sk_storage_get() also allows to
"create" new elem if one does not exist in the sk.  It is done by
the new BPF_SK_STORAGE_GET_F_CREATE flag.  An optional value can also be
provided as the initial value during BPF_SK_STORAGE_GET_F_CREATE.
The BPF_MAP_TYPE_SK_STORAGE also supports bpf_spin_lock.  Together,
it has eliminated the potential use cases for an equivalent
bpf_map_update_elem() API (for bpf_prog) in this patch.

Misc notes:
----------
1. map_get_next_key is not supported.  From the userspace syscall
   perspective,  the map has the socket fd as the key while the map
   can be shared by pinned-file or map-id.

   Since btf is enforced, the existing "ss" could be enhanced to pretty
   print the local-storage.

   Supporting a kernel defined btf with 4 tuples as the return key could
   be explored later also.

2. The sk->sk_lock cannot be acquired.  Atomic operations is used instead=
.
   e.g. cmpxchg is done on the sk->sk_bpf_storage ptr.
   Please refer to the source code comments for the details in
   synchronization cases and considerations.

3. The mem is charged to the sk->sk_omem_alloc as the sk filter does.

Benchmark:
---------
Here is the benchmark data collected by turning on
the "kernel.bpf_stats_enabled" sysctl.
Two bpf progs are tested:

One bpf prog with the usual bpf hashmap (max_entries =3D 8192) with the
sk ptr as the key. (verifier is modified to support sk ptr as the key
That should have shortened the key lookup time.)

Another bpf prog is with the new BPF_MAP_TYPE_SK_STORAGE.

Both are storing a "u32 cnt", do a lookup on "egress_skb/cgroup" for
each egress skb and then bump the cnt.  netperf is used to drive
data with 4096 connected UDP sockets.

BPF_MAP_TYPE_HASH with a modifier verifier (152ns per bpf run)
27: cgroup_skb  name egress_sk_map  tag 74f56e832918070b run_time_ns 5828=
0107540 run_cnt 381347633
    loaded_at 2019-04-15T13:46:39-0700  uid 0
    xlated 344B  jited 258B  memlock 4096B  map_ids 16
    btf_id 5

BPF_MAP_TYPE_SK_STORAGE in this patch (66ns per bpf run)
30: cgroup_skb  name egress_sk_stora  tag d4aa70984cc7bbf6 run_time_ns 25=
617093319 run_cnt 390989739
    loaded_at 2019-04-15T13:47:54-0700  uid 0
    xlated 168B  jited 156B  memlock 4096B  map_ids 17
    btf_id 6

Here is a high-level picture on how are the objects organized:

       sk
    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90
    =E2=94=82      =E2=94=82
    =E2=94=82      =E2=94=82
    =E2=94=82      =E2=94=82
    =E2=94=82*sk_bpf_storage=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=96=B6 bpf_sk_storage
    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90
                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 list  =E2=94=
=82
                 =E2=94=82           =E2=94=82       =E2=94=82
                 =E2=94=82           =E2=94=82       =E2=94=82
                 =E2=94=82           =E2=94=82       =E2=94=82
                 =E2=94=82           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
                 =E2=94=82
                 =E2=94=82     elem
                 =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
                 =E2=94=9C=E2=94=80=E2=96=B6=E2=94=82 snode  =E2=94=82
                 =E2=94=82  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
                 =E2=94=82  =E2=94=82  data  =E2=94=82          bpf_map
                 =E2=94=82  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4        =E2=94=8C=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90
                 =E2=94=82  =E2=94=82map_node=E2=94=82=E2=97=80=E2=94=80=E2=
=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4  list   =E2=94=
=82
                 =E2=94=82  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =E2=94=82     =E2=94=82   =
      =E2=94=82
                 =E2=94=82              =E2=94=82     =E2=94=82         =E2=
=94=82
                 =E2=94=82     elem     =E2=94=82     =E2=94=82         =E2=
=94=82
                 =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=82     =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
                 =E2=94=94=E2=94=80=E2=96=B6=E2=94=82 snode  =E2=94=82  =E2=
=94=82
                    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=A4  =E2=94=82
   bpf_map          =E2=94=82  data  =E2=94=82  =E2=94=82
 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4  =E2=94=82
 =E2=94=82  list   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=96=B6=E2=94=82map_node=E2=94=82  =E2=94=82
 =E2=94=82         =E2=94=82        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =E2=94=82
 =E2=94=82         =E2=94=82                    =E2=94=82
 =E2=94=82         =E2=94=82           elem     =E2=94=82
 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=82
                 =E2=94=8C=E2=94=80=E2=96=B6=E2=94=82 snode  =E2=94=82  =E2=
=94=82
                 =E2=94=82  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4  =E2=94=82
                 =E2=94=82  =E2=94=82  data  =E2=94=82  =E2=94=82
                 =E2=94=82  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4  =E2=94=82
                 =E2=94=82  =E2=94=82map_node=E2=94=82=E2=97=80=E2=94=80=E2=
=94=98
                 =E2=94=82  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
                 =E2=94=82
                 =E2=94=82
                 =E2=94=82          =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
     sk          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=82 list  =E2=94=82
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=
                  =E2=94=82       =E2=94=82
  =E2=94=82      =E2=94=82                  =E2=94=82       =E2=94=82
  =E2=94=82      =E2=94=82                  =E2=94=82       =E2=94=82
  =E2=94=82      =E2=94=82                  =E2=94=94=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
  =E2=94=82*sk_bpf_storage=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=96=B6bpf_sk_storage
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_types.h    |   1 +
 include/net/bpf_sk_storage.h |  13 +
 include/net/sock.h           |   5 +
 include/uapi/linux/bpf.h     |  44 +-
 kernel/bpf/syscall.c         |   3 +-
 kernel/bpf/verifier.c        |  27 +-
 net/bpf/test_run.c           |   2 +
 net/core/Makefile            |   1 +
 net/core/bpf_sk_storage.c    | 804 +++++++++++++++++++++++++++++++++++
 net/core/filter.c            |  12 +
 net/core/sock.c              |   5 +
 12 files changed, 914 insertions(+), 5 deletions(-)
 create mode 100644 include/net/bpf_sk_storage.h
 create mode 100644 net/core/bpf_sk_storage.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f15432d90728..0d2788beacd2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -184,6 +184,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_MAP_KEY,	/* pointer to stack used as map key */
 	ARG_PTR_TO_MAP_VALUE,	/* pointer to stack used as map value */
 	ARG_PTR_TO_UNINIT_MAP_VALUE,	/* pointer to valid memory used to store a=
 map value */
+	ARG_PTR_TO_MAP_VALUE_OR_NULL,	/* pointer to stack used as map value or =
NULL */
=20
 	/* the following constraints used to prototype bpf_memcmp() and other
 	 * functions that access data on eBPF program stack
@@ -204,6 +205,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
 	ARG_PTR_TO_INT,		/* pointer to int */
 	ARG_PTR_TO_LONG,	/* pointer to long */
+	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 };
=20
 /* type of values returned from helper functions */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index d26991a16894..eb1e4f867a5e 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -60,6 +60,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY_OF_MAPS, array_of_maps_=
map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
 #ifdef CONFIG_NET
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
 #if defined(CONFIG_BPF_STREAM_PARSER)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
new file mode 100644
index 000000000000..b9dcb02e756b
--- /dev/null
+++ b/include/net/bpf_sk_storage.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 Facebook */
+#ifndef _BPF_SK_STORAGE_H
+#define _BPF_SK_STORAGE_H
+
+struct sock;
+
+void bpf_sk_storage_free(struct sock *sk);
+
+extern const struct bpf_func_proto bpf_sk_storage_get_proto;
+extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+
+#endif /* _BPF_SK_STORAGE_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 784cd19d5ff7..4d208c0f9c14 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -236,6 +236,8 @@ struct sock_common {
 	/* public: */
 };
=20
+struct bpf_sk_storage;
+
 /**
   *	struct sock - network layer representation of sockets
   *	@__sk_common: shared layout with inet_timewait_sock
@@ -510,6 +512,9 @@ struct sock {
 #endif
 	void                    (*sk_destruct)(struct sock *sk);
 	struct sock_reuseport __rcu	*sk_reuseport_cb;
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_sk_storage __rcu	*sk_bpf_storage;
+#endif
 	struct rcu_head		sk_rcu;
 };
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index eaf2d3284248..080ff8313ced 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -133,6 +133,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 	BPF_MAP_TYPE_QUEUE,
 	BPF_MAP_TYPE_STACK,
+	BPF_MAP_TYPE_SK_STORAGE,
 };
=20
 /* Note that tracing related programs such as
@@ -2629,6 +2630,42 @@ union bpf_attr {
  *		was provided.
  *
  *		**-ERANGE** if resulting value was out of range.
+ *
+ * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, vo=
id *value, u64 flags)
+ *	Description
+ *		Get a bpf-local-storage from a sk.
+ *
+ *		Logically, it could be thought of getting the value from
+ *		a *map* with *sk* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem(map, &sk)** except this
+ *		helper enforces the key must be a **bpf_fullsock()**
+ *		and the map must be a BPF_MAP_TYPE_SK_STORAGE also.
+ *
+ *		Underneath, the value is stored locally at *sk* instead of
+ *		the map.  The *map* is used as the bpf-local-storage **type**.
+ *		The bpf-local-storage **type** (i.e. the *map*) is searched
+ *		against all bpf-local-storages residing at sk.
+ *
+ *		An optional *flags* (BPF_SK_STORAGE_GET_F_CREATE) can be
+ *		used such that a new bpf-local-storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with BPF_SK_STORAGE_GET_F_CREATE to specify
+ *		the initial value of a bpf-local-storage.  If *value* is
+ *		NULL, the new bpf-local-storage will be zero initialized.
+ *	Return
+ *		A bpf-local-storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf-local-storage.
+ *
+ * int bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ *	Description
+ *		Delete a bpf-local-storage from a sk.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf-local-storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2737,7 +2774,9 @@ union bpf_attr {
 	FN(sysctl_get_new_value),	\
 	FN(sysctl_set_new_value),	\
 	FN(strtol),			\
-	FN(strtoul),
+	FN(strtoul),			\
+	FN(sk_storage_get),		\
+	FN(sk_storage_delete),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
@@ -2813,6 +2852,9 @@ enum bpf_func_id {
 /* BPF_FUNC_sysctl_get_name flags. */
 #define BPF_F_SYSCTL_BASE_NAME		(1ULL << 0)
=20
+/* BPF_FUNC_sk_storage_get flags */
+#define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b0de49598341..b863e6ee86f5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -526,7 +526,8 @@ static int map_check_btf(struct bpf_map *map, const s=
truct btf *btf,
 			return -EACCES;
 		if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
 		    map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
-		    map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE)
+		    map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
+		    map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
 			return -ENOTSUPP;
 		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
 		    map->value_size) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dc01abd27849..6ed13a03cdec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2525,10 +2525,15 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 regno,
=20
 	if (arg_type =3D=3D ARG_PTR_TO_MAP_KEY ||
 	    arg_type =3D=3D ARG_PTR_TO_MAP_VALUE ||
-	    arg_type =3D=3D ARG_PTR_TO_UNINIT_MAP_VALUE) {
+	    arg_type =3D=3D ARG_PTR_TO_UNINIT_MAP_VALUE ||
+	    arg_type =3D=3D ARG_PTR_TO_MAP_VALUE_OR_NULL) {
 		expected_type =3D PTR_TO_STACK;
-		if (!type_is_pkt_pointer(type) && type !=3D PTR_TO_MAP_VALUE &&
-		    type !=3D expected_type)
+		if (register_is_null(reg) &&
+		    arg_type =3D=3D ARG_PTR_TO_MAP_VALUE_OR_NULL)
+			/* final test in check_stack_boundary() */;
+		else if (!type_is_pkt_pointer(type) &&
+			 type !=3D PTR_TO_MAP_VALUE &&
+			 type !=3D expected_type)
 			goto err_type;
 	} else if (arg_type =3D=3D ARG_CONST_SIZE ||
 		   arg_type =3D=3D ARG_CONST_SIZE_OR_ZERO) {
@@ -2560,6 +2565,10 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 regno,
 			}
 			meta->ref_obj_id =3D reg->ref_obj_id;
 		}
+	} else if (arg_type =3D=3D ARG_PTR_TO_SOCKET) {
+		expected_type =3D PTR_TO_SOCKET;
+		if (type !=3D expected_type)
+			goto err_type;
 	} else if (arg_type =3D=3D ARG_PTR_TO_SPIN_LOCK) {
 		if (meta->func_id =3D=3D BPF_FUNC_spin_lock) {
 			if (process_spin_lock(env, regno, true))
@@ -2617,6 +2626,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 regno,
 					      meta->map_ptr->key_size, false,
 					      NULL);
 	} else if (arg_type =3D=3D ARG_PTR_TO_MAP_VALUE ||
+		   (arg_type =3D=3D ARG_PTR_TO_MAP_VALUE_OR_NULL &&
+		    !register_is_null(reg)) ||
 		   arg_type =3D=3D ARG_PTR_TO_UNINIT_MAP_VALUE) {
 		/* bpf_map_xxx(..., map_ptr, ..., value) call:
 		 * check [value, value + map->value_size) validity
@@ -2766,6 +2777,11 @@ static int check_map_func_compatibility(struct bpf=
_verifier_env *env,
 		    func_id !=3D BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_SK_STORAGE:
+		if (func_id !=3D BPF_FUNC_sk_storage_get &&
+		    func_id !=3D BPF_FUNC_sk_storage_delete)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -2829,6 +2845,11 @@ static int check_map_func_compatibility(struct bpf=
_verifier_env *env,
 		    map->map_type !=3D BPF_MAP_TYPE_STACK)
 			goto error;
 		break;
+	case BPF_FUNC_sk_storage_get:
+	case BPF_FUNC_sk_storage_delete:
+		if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8606e5aef0b6..8c9331913753 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -10,6 +10,7 @@
 #include <linux/etherdevice.h>
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
+#include <net/bpf_sk_storage.h>
 #include <net/sock.h>
 #include <net/tcp.h>
=20
@@ -331,6 +332,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, cons=
t union bpf_attr *kattr,
 				     sizeof(struct __sk_buff));
 out:
 	kfree_skb(skb);
+	bpf_sk_storage_free(sk);
 	kfree(sk);
 	kfree(ctx);
 	return ret;
diff --git a/net/core/Makefile b/net/core/Makefile
index f97d6254e564..a104dc8faafc 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_HWBM) +=3D hwbm.o
 obj-$(CONFIG_NET_DEVLINK) +=3D devlink.o
 obj-$(CONFIG_GRO_CELLS) +=3D gro_cells.o
 obj-$(CONFIG_FAILOVER) +=3D failover.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_sk_storage.o
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
new file mode 100644
index 000000000000..a8e9ac71b22d
--- /dev/null
+++ b/net/core/bpf_sk_storage.c
@@ -0,0 +1,804 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook  */
+#include <linux/rculist.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/bpf.h>
+#include <net/bpf_sk_storage.h>
+#include <net/sock.h>
+#include <uapi/linux/btf.h>
+
+static atomic_t cache_idx;
+
+struct bucket {
+	struct hlist_head list;
+	raw_spinlock_t lock;
+};
+
+/* Thp map is not the primary owner of a bpf_sk_storage_elem.
+ * Instead, the sk->sk_bpf_storage is.
+ *
+ * The map (bpf_sk_storage_map) is for two purposes
+ * 1. Define the size of the "sk local storage".  It is
+ *    the map's value_size.
+ *
+ * 2. Maintain a list to keep track of all elems such
+ *    that they can be cleaned up during the map destruction.
+ *
+ * When a bpf local storage is being looked up for a
+ * particular sk,  the "bpf_map" pointer is actually used
+ * as the "key" to search in the list of elem in
+ * sk->sk_bpf_storage.
+ *
+ * Hence, consider sk->sk_bpf_storage is the mini-map
+ * with the "bpf_map" pointer as the searching key.
+ */
+struct bpf_sk_storage_map {
+	struct bpf_map map;
+	/* Lookup elem does not require accessing the map.
+	 *
+	 * Updating/Deleting requires a bucket lock to
+	 * link/unlink the elem from the map.  Having
+	 * multiple buckets to improve contention.
+	 */
+	struct bucket *buckets;
+	u32 bucket_log;
+	u16 elem_size;
+	u16 cache_idx;
+};
+
+struct bpf_sk_storage_data {
+	/* smap is used as the searching key when looking up
+	 * from sk->sk_bpf_storage.
+	 *
+	 * Put it in the same cacheline as the data to minimize
+	 * the number of cachelines access during the cache hit case.
+	 */
+	struct bpf_sk_storage_map __rcu *smap;
+	u8 data[0] __aligned(8);
+};
+
+/* Linked to bpf_sk_storage and bpf_sk_storage_map */
+struct bpf_sk_storage_elem {
+	struct hlist_node map_node;	/* Linked to bpf_sk_storage_map */
+	struct hlist_node snode;	/* Linked to bpf_sk_storage */
+	struct bpf_sk_storage __rcu *sk_storage;
+	struct rcu_head rcu;
+	/* 8 bytes hole */
+	/* The data is stored in aother cacheline to minimize
+	 * the number of cachelines access during a cache hit.
+	 */
+	struct bpf_sk_storage_data sdata ____cacheline_aligned;
+};
+
+#define SELEM(_SDATA) container_of((_SDATA), struct bpf_sk_storage_elem,=
 sdata)
+#define SDATA(_SELEM) (&(_SELEM)->sdata)
+#define BPF_SK_STORAGE_CACHE_SIZE	16
+
+struct bpf_sk_storage {
+	struct bpf_sk_storage_data __rcu *cache[BPF_SK_STORAGE_CACHE_SIZE];
+	struct hlist_head list;	/* List of bpf_sk_storage_elem */
+	struct sock *sk;	/* The sk that owns the the above "list" of
+				 * bpf_sk_storage_elem.
+				 */
+	struct rcu_head rcu;
+	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+};
+
+static struct bucket *select_bucket(struct bpf_sk_storage_map *smap,
+				    struct bpf_sk_storage_elem *selem)
+{
+	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+}
+
+static int omem_charge(struct sock *sk, unsigned int size)
+{
+	/* same check as in sock_kmalloc() */
+	if (size <=3D sysctl_optmem_max &&
+	    atomic_read(&sk->sk_omem_alloc) + size < sysctl_optmem_max) {
+		atomic_add(size, &sk->sk_omem_alloc);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static bool selem_linked_to_sk(const struct bpf_sk_storage_elem *selem)
+{
+	return !hlist_unhashed(&selem->snode);
+}
+
+static bool selem_linked_to_map(const struct bpf_sk_storage_elem *selem)
+{
+	return !hlist_unhashed(&selem->map_node);
+}
+
+static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map=
 *smap,
+					       struct sock *sk, void *value,
+					       bool charge_omem)
+{
+	struct bpf_sk_storage_elem *selem;
+
+	if (charge_omem && omem_charge(sk, smap->elem_size))
+		return NULL;
+
+	selem =3D kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
+	if (selem) {
+		if (value)
+			memcpy(SDATA(selem)->data, value, smap->map.value_size);
+		return selem;
+	}
+
+	if (charge_omem)
+		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+
+	return NULL;
+}
+
+/* sk_storage->lock must be held and selem->sk_storage =3D=3D sk_storage=
.
+ * The caller must ensure selem->smap is still valid to be
+ * dereferenced for its smap->elem_size and smap->cache_idx.
+ */
+static bool __selem_unlink_sk(struct bpf_sk_storage *sk_storage,
+			      struct bpf_sk_storage_elem *selem,
+			      bool uncharge_omem)
+{
+	struct bpf_sk_storage_map *smap;
+	bool free_sk_storage;
+	struct sock *sk;
+
+	smap =3D rcu_dereference(SDATA(selem)->smap);
+	sk =3D sk_storage->sk;
+
+	/* All uncharging on sk->sk_omem_alloc must be done first.
+	 * sk may be freed once the last selem is unlinked from sk_storage.
+	 */
+	if (uncharge_omem)
+		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+
+	free_sk_storage =3D hlist_is_singular_node(&selem->snode,
+						 &sk_storage->list);
+	if (free_sk_storage) {
+		atomic_sub(sizeof(struct bpf_sk_storage), &sk->sk_omem_alloc);
+		sk_storage->sk =3D NULL;
+		/* After this RCU_INIT, sk may be freed and cannot be used */
+		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
+
+		/* sk_storage is not freed now.  sk_storage->lock is
+		 * still held and raw_spin_unlock_bh(&sk_storage->lock)
+		 * will be done by the caller.
+		 *
+		 * Although the unlock will be done under
+		 * rcu_read_lock(),  it is more intutivie to
+		 * read if kfree_rcu(sk_storage, rcu) is done
+		 * after the raw_spin_unlock_bh(&sk_storage->lock).
+		 *
+		 * Hence, a "bool free_sk_storage" is returned
+		 * to the caller which then calls the kfree_rcu()
+		 * after unlock.
+		 */
+	}
+	hlist_del_init_rcu(&selem->snode);
+	if (rcu_access_pointer(sk_storage->cache[smap->cache_idx]) =3D=3D
+	    SDATA(selem))
+		RCU_INIT_POINTER(sk_storage->cache[smap->cache_idx], NULL);
+
+	kfree_rcu(selem, rcu);
+
+	return free_sk_storage;
+}
+
+static void selem_unlink_sk(struct bpf_sk_storage_elem *selem)
+{
+	struct bpf_sk_storage *sk_storage;
+	bool free_sk_storage =3D false;
+
+	if (unlikely(!selem_linked_to_sk(selem)))
+		/* selem has already been unlinked from sk */
+		return;
+
+	sk_storage =3D rcu_dereference(selem->sk_storage);
+	raw_spin_lock_bh(&sk_storage->lock);
+	if (likely(selem_linked_to_sk(selem)))
+		free_sk_storage =3D __selem_unlink_sk(sk_storage, selem, true);
+	raw_spin_unlock_bh(&sk_storage->lock);
+
+	if (free_sk_storage)
+		kfree_rcu(sk_storage, rcu);
+}
+
+/* sk_storage->lock must be held and sk_storage->list cannot be empty */
+static void __selem_link_sk(struct bpf_sk_storage *sk_storage,
+			    struct bpf_sk_storage_elem *selem)
+{
+	RCU_INIT_POINTER(selem->sk_storage, sk_storage);
+	hlist_add_head(&selem->snode, &sk_storage->list);
+}
+
+static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
+{
+	struct bpf_sk_storage_map *smap;
+	struct bucket *b;
+
+	if (unlikely(!selem_linked_to_map(selem)))
+		/* selem has already be unlinked from smap */
+		return;
+
+	smap =3D rcu_dereference(SDATA(selem)->smap);
+	b =3D select_bucket(smap, selem);
+	raw_spin_lock_bh(&b->lock);
+	if (likely(selem_linked_to_map(selem)))
+		hlist_del_init_rcu(&selem->map_node);
+	raw_spin_unlock_bh(&b->lock);
+}
+
+static void selem_link_map(struct bpf_sk_storage_map *smap,
+			   struct bpf_sk_storage_elem *selem)
+{
+	struct bucket *b =3D select_bucket(smap, selem);
+
+	raw_spin_lock_bh(&b->lock);
+	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+	hlist_add_head_rcu(&selem->map_node, &b->list);
+	raw_spin_unlock_bh(&b->lock);
+}
+
+static void selem_unlink(struct bpf_sk_storage_elem *selem)
+{
+	/* Always unlink from map before unlinking from sk_storage
+	 * because selem will be freed after successfully unlinked from
+	 * the sk_storage.
+	 */
+	selem_unlink_map(selem);
+	selem_unlink_sk(selem);
+}
+
+static struct bpf_sk_storage_data *
+__sk_storage_lookup(struct bpf_sk_storage *sk_storage,
+		    struct bpf_sk_storage_map *smap,
+		    bool cacheit_lockit)
+{
+	struct bpf_sk_storage_data *sdata;
+	struct bpf_sk_storage_elem *selem;
+
+	/* Fast path (cache hit) */
+	sdata =3D rcu_dereference(sk_storage->cache[smap->cache_idx]);
+	if (sdata && rcu_access_pointer(sdata->smap) =3D=3D smap)
+		return sdata;
+
+	/* Slow path (cache miss) */
+	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode)
+		if (rcu_access_pointer(SDATA(selem)->smap) =3D=3D smap)
+			break;
+
+	if (!selem)
+		return NULL;
+
+	sdata =3D SDATA(selem);
+	if (cacheit_lockit) {
+		/* spinlock is needed to avoid racing with the
+		 * parallel delete.  Otherwise, publishing an already
+		 * deleted sdata to the cache will become a use-after-free
+		 * problem in the next __sk_storage_lookup().
+		 */
+		raw_spin_lock_bh(&sk_storage->lock);
+		if (selem_linked_to_sk(selem))
+			rcu_assign_pointer(sk_storage->cache[smap->cache_idx],
+					   sdata);
+		raw_spin_unlock_bh(&sk_storage->lock);
+	}
+
+	return sdata;
+}
+
+static struct bpf_sk_storage_data *
+sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_loc=
kit)
+{
+	struct bpf_sk_storage *sk_storage;
+	struct bpf_sk_storage_map *smap;
+
+	sk_storage =3D rcu_dereference(sk->sk_bpf_storage);
+	if (!sk_storage)
+		return NULL;
+
+	smap =3D (struct bpf_sk_storage_map *)map;
+	return __sk_storage_lookup(sk_storage, smap, cacheit_lockit);
+}
+
+static int check_flags(const struct bpf_sk_storage_data *old_sdata,
+		       u64 map_flags)
+{
+	if (old_sdata && (map_flags & ~BPF_F_LOCK) =3D=3D BPF_NOEXIST)
+		/* elem already exists */
+		return -EEXIST;
+
+	if (!old_sdata && (map_flags & ~BPF_F_LOCK) =3D=3D BPF_EXIST)
+		/* elem doesn't exist, cannot update it */
+		return -ENOENT;
+
+	return 0;
+}
+
+static int sk_storage_alloc(struct sock *sk,
+			    struct bpf_sk_storage_map *smap,
+			    struct bpf_sk_storage_elem *first_selem)
+{
+	struct bpf_sk_storage *prev_sk_storage, *sk_storage;
+	int err;
+
+	err =3D omem_charge(sk, sizeof(*sk_storage));
+	if (err)
+		return err;
+
+	sk_storage =3D kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN);
+	if (!sk_storage) {
+		err =3D -ENOMEM;
+		goto uncharge;
+	}
+	INIT_HLIST_HEAD(&sk_storage->list);
+	raw_spin_lock_init(&sk_storage->lock);
+	sk_storage->sk =3D sk;
+
+	__selem_link_sk(sk_storage, first_selem);
+	selem_link_map(smap, first_selem);
+	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
+	 * Hence, atomic ops is used to set sk->sk_bpf_storage
+	 * from NULL to the newly allocated sk_storage ptr.
+	 *
+	 * From now on, the sk->sk_bpf_storage pointer is protected
+	 * by the sk_storage->lock.  Hence,  when freeing
+	 * the sk->sk_bpf_storage, the sk_storage->lock must
+	 * be held before setting sk->sk_bpf_storage to NULL.
+	 */
+	prev_sk_storage =3D cmpxchg((struct bpf_sk_storage **)&sk->sk_bpf_stora=
ge,
+				  NULL, sk_storage);
+	if (unlikely(prev_sk_storage)) {
+		selem_unlink_map(first_selem);
+		err =3D -EAGAIN;
+		goto uncharge;
+
+		/* Note that even first_selem was linked to smap's
+		 * bucket->list, first_selem can be freed immediately
+		 * (instead of kfree_rcu) because
+		 * bpf_sk_storage_map_free() does a
+		 * synchronize_rcu() before walking the bucket->list.
+		 * Hence, no one is accessing selem from the
+		 * bucket->list under rcu_read_lock().
+		 */
+	}
+
+	return 0;
+
+uncharge:
+	kfree(sk_storage);
+	atomic_sub(sizeof(*sk_storage), &sk->sk_omem_alloc);
+	return err;
+}
+
+/* sk cannot be going away because it is linking new elem
+ * to sk->sk_bpf_storage. (i.e. sk->sk_refcnt cannot be 0).
+ * Otherwise, it will become a leak (and other memory issues
+ * during map destruction).
+ */
+static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
+						     struct bpf_map *map,
+						     void *value,
+						     u64 map_flags)
+{
+	struct bpf_sk_storage_data *old_sdata =3D NULL;
+	struct bpf_sk_storage_elem *selem;
+	struct bpf_sk_storage *sk_storage;
+	struct bpf_sk_storage_map *smap;
+	int err;
+
+	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
+	    /* BPF_F_LOCK can only be used in a value with spin_lock */
+	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map))=
)
+		return ERR_PTR(-EINVAL);
+
+	smap =3D (struct bpf_sk_storage_map *)map;
+	sk_storage =3D rcu_dereference(sk->sk_bpf_storage);
+	if (!sk_storage || hlist_empty(&sk_storage->list)) {
+		/* Very first elem for this sk */
+		err =3D check_flags(NULL, map_flags);
+		if (err)
+			return ERR_PTR(err);
+
+		selem =3D selem_alloc(smap, sk, value, true);
+		if (!selem)
+			return ERR_PTR(-ENOMEM);
+
+		err =3D sk_storage_alloc(sk, smap, selem);
+		if (err) {
+			kfree(selem);
+			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+			return ERR_PTR(err);
+		}
+
+		return SDATA(selem);
+	}
+
+	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
+		/* Hoping to find an old_sdata to do inline update
+		 * such that it can avoid taking the sk_storage->lock
+		 * and changing the lists.
+		 */
+		old_sdata =3D __sk_storage_lookup(sk_storage, smap, false);
+		err =3D check_flags(old_sdata, map_flags);
+		if (err)
+			return ERR_PTR(err);
+		if (old_sdata && selem_linked_to_sk(SELEM(old_sdata))) {
+			copy_map_value_locked(map, old_sdata->data,
+					      value, false);
+			return old_sdata;
+		}
+	}
+
+	raw_spin_lock_bh(&sk_storage->lock);
+
+	/* Recheck sk_storage->list under sk_storage->lock */
+	if (unlikely(hlist_empty(&sk_storage->list))) {
+		/* A parallel del is happening and sk_storage is going
+		 * away.  It has just been checked before, so very
+		 * unlikely.  Return instead of retry to keep things
+		 * simple.
+		 */
+		err =3D -EAGAIN;
+		goto unlock_err;
+	}
+
+	old_sdata =3D __sk_storage_lookup(sk_storage, smap, false);
+	err =3D check_flags(old_sdata, map_flags);
+	if (err)
+		goto unlock_err;
+
+	if (old_sdata && (map_flags & BPF_F_LOCK)) {
+		copy_map_value_locked(map, old_sdata->data, value, false);
+		selem =3D SELEM(old_sdata);
+		goto unlock;
+	}
+
+	/* sk_storage->lock is held.  Hence, we are sure
+	 * we can unlink and uncharge the old_sdata successfully
+	 * later.  Hence, instead of charging the new selem now
+	 * and then uncharge the old selem later (which may cause
+	 * a potential but unnecessary charge failure),  avoid taking
+	 * a charge at all here (the "!old_sdata" check) and the
+	 * old_sdata will not be uncharged later during __selem_unlink_sk().
+	 */
+	selem =3D selem_alloc(smap, sk, value, !old_sdata);
+	if (!selem) {
+		err =3D -ENOMEM;
+		goto unlock_err;
+	}
+
+	/* First, link the new selem to the map */
+	selem_link_map(smap, selem);
+
+	/* Second, link (and publish) the new selem to sk_storage */
+	__selem_link_sk(sk_storage, selem);
+
+	/* Third, remove old selem, SELEM(old_sdata) */
+	if (old_sdata) {
+		selem_unlink_map(SELEM(old_sdata));
+		__selem_unlink_sk(sk_storage, SELEM(old_sdata), false);
+	}
+
+unlock:
+	raw_spin_unlock_bh(&sk_storage->lock);
+	return SDATA(selem);
+
+unlock_err:
+	raw_spin_unlock_bh(&sk_storage->lock);
+	return ERR_PTR(err);
+}
+
+static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
+{
+	struct bpf_sk_storage_data *sdata;
+
+	sdata =3D sk_storage_lookup(sk, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	selem_unlink(SELEM(sdata));
+
+	return 0;
+}
+
+/* Called by __sk_destruct() */
+void bpf_sk_storage_free(struct sock *sk)
+{
+	struct bpf_sk_storage_elem *selem;
+	struct bpf_sk_storage *sk_storage;
+	bool free_sk_storage =3D false;
+	struct hlist_node *n;
+
+	rcu_read_lock();
+	sk_storage =3D rcu_dereference(sk->sk_bpf_storage);
+	if (!sk_storage) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* Netiher the bpf_prog nor the bpf-map's syscall
+	 * could be modifying the sk_storage->list now.
+	 * Thus, no elem can be added-to or deleted-from the
+	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
+	 *
+	 * It is racing with bpf_sk_storage_map_free() alone
+	 * when unlinking elem from the sk_storage->list and
+	 * the map's bucket->list.
+	 */
+	raw_spin_lock_bh(&sk_storage->lock);
+	hlist_for_each_entry_safe(selem, n, &sk_storage->list, snode) {
+		/* Always unlink from map before unlinking from
+		 * sk_storage.
+		 */
+		selem_unlink_map(selem);
+		free_sk_storage =3D __selem_unlink_sk(sk_storage, selem, true);
+	}
+	raw_spin_unlock_bh(&sk_storage->lock);
+	rcu_read_unlock();
+
+	if (free_sk_storage)
+		kfree_rcu(sk_storage, rcu);
+}
+
+static void bpf_sk_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_sk_storage_elem *selem;
+	struct bpf_sk_storage_map *smap;
+	struct bucket *b;
+	unsigned int i;
+
+	smap =3D (struct bpf_sk_storage_map *)map;
+
+	synchronize_rcu();
+
+	/* bpf prog and the userspace can no longer access this map
+	 * now.  No new selem (of this map) can be added
+	 * to the sk->sk_bpf_storage or to the map bucket's list.
+	 *
+	 * The elem of this map can be cleaned up here
+	 * or
+	 * by bpf_sk_storage_free() during __sk_destruct().
+	 */
+	for (i =3D 0; i < (1U << smap->bucket_log); i++) {
+		b =3D &smap->buckets[i];
+
+		rcu_read_lock();
+		/* No one is adding to b->list now */
+		while ((selem =3D hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu=
(&b->list)),
+						 struct bpf_sk_storage_elem,
+						 map_node))) {
+			selem_unlink(selem);
+			cond_resched_rcu();
+		}
+		rcu_read_unlock();
+	}
+
+	/* bpf_sk_storage_free() may still need to access the map.
+	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
+	 * which then made the above while((selem =3D ...)) loop
+	 * exited immediately.
+	 *
+	 * However, the bpf_sk_storage_free() still needs to access
+	 * the smap->elem_size to do the uncharging in
+	 * __selem_unlink_sk().
+	 *
+	 * Hence, wait another rcu grace period for the
+	 * bpf_sk_storage_free() to finish.
+	 */
+	synchronize_rcu();
+
+	kvfree(smap->buckets);
+	kfree(map);
+}
+
+static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
+{
+	if (attr->map_flags !=3D BPF_F_NO_PREALLOC || attr->max_entries ||
+	    attr->key_size !=3D sizeof(int) || !attr->value_size ||
+	    /* Enforce BTF for userspace sk dumping */
+	    !attr->btf_key_type_id || !attr->btf_value_type_id)
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (attr->value_size >=3D KMALLOC_MAX_SIZE -
+	    MAX_BPF_STACK - sizeof(struct bpf_sk_storage_elem) ||
+	    /* U16_MAX is much more than enough for sk local storage
+	     * considering a tcp_sock is ~2k.
+	     */
+	    attr->value_size > U16_MAX - sizeof(struct bpf_sk_storage_elem))
+		return -E2BIG;
+
+	return 0;
+}
+
+static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_sk_storage_map *smap;
+	unsigned int i;
+	u32 nbuckets;
+	u64 cost;
+
+	smap =3D kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
+	if (!smap)
+		return ERR_PTR(-ENOMEM);
+	bpf_map_init_from_attr(&smap->map, attr);
+
+	smap->bucket_log =3D ilog2(roundup_pow_of_two(num_possible_cpus()));
+	nbuckets =3D 1U << smap->bucket_log;
+	smap->buckets =3D kvcalloc(sizeof(*smap->buckets), nbuckets,
+				 GFP_USER | __GFP_NOWARN);
+	if (!smap->buckets) {
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+	cost =3D sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
+
+	for (i =3D 0; i < nbuckets; i++) {
+		INIT_HLIST_HEAD(&smap->buckets[i].list);
+		raw_spin_lock_init(&smap->buckets[i].lock);
+	}
+
+	smap->elem_size =3D sizeof(struct bpf_sk_storage_elem) + attr->value_si=
ze;
+	smap->cache_idx =3D (unsigned int)atomic_inc_return(&cache_idx) %
+		BPF_SK_STORAGE_CACHE_SIZE;
+	smap->map.pages =3D round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
+
+	return &smap->map;
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key,
+				void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
+					const struct btf *btf,
+					const struct btf_type *key_type,
+					const struct btf_type *value_type)
+{
+	u32 int_data;
+
+	if (BTF_INFO_KIND(key_type->info) !=3D BTF_KIND_INT)
+		return -EINVAL;
+
+	int_data =3D *(u32 *)(key_type + 1);
+	if (BTF_INT_BITS(int_data) !=3D 32 || BTF_INT_OFFSET(int_data))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *ke=
y)
+{
+	struct bpf_sk_storage_data *sdata;
+	struct socket *sock;
+	int fd, err;
+
+	fd =3D *(int *)key;
+	sock =3D sockfd_lookup(fd, &err);
+	if (sock) {
+		sdata =3D sk_storage_lookup(sock->sk, map, true);
+		sockfd_put(sock);
+		return sdata ? sdata->data : NULL;
+	}
+
+	return ERR_PTR(err);
+}
+
+static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
+					 void *value, u64 map_flags)
+{
+	struct bpf_sk_storage_data *sdata;
+	struct socket *sock;
+	int fd, err;
+
+	fd =3D *(int *)key;
+	sock =3D sockfd_lookup(fd, &err);
+	if (sock) {
+		sdata =3D sk_storage_update(sock->sk, map, value, map_flags);
+		sockfd_put(sock);
+		return IS_ERR(sdata) ? PTR_ERR(sdata) : 0;
+	}
+
+	return err;
+}
+
+static int bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct socket *sock;
+	int fd, err;
+
+	fd =3D *(int *)key;
+	sock =3D sockfd_lookup(fd, &err);
+	if (sock) {
+		err =3D sk_storage_delete(sock->sk, map);
+		sockfd_put(sock);
+		return err;
+	}
+
+	return err;
+}
+
+BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags)
+{
+	struct bpf_sk_storage_data *sdata;
+
+	if (flags > BPF_SK_STORAGE_GET_F_CREATE)
+		return (unsigned long)NULL;
+
+	sdata =3D sk_storage_lookup(sk, map, true);
+	if (sdata)
+		return (unsigned long)sdata->data;
+
+	if (flags =3D=3D BPF_SK_STORAGE_GET_F_CREATE &&
+	    /* Cannot add new elem to a going away sk.
+	     * Otherwise, the new elem may become a leak
+	     * (and also other memory issues during map
+	     *  destruction).
+	     */
+	    refcount_inc_not_zero(&sk->sk_refcnt)) {
+		sdata =3D sk_storage_update(sk, map, value, BPF_NOEXIST);
+		/* sk must be a fullsock (guaranteed by verifier),
+		 * so sock_gen_put() is unnecessary.
+		 */
+		sock_put(sk);
+		return IS_ERR(sdata) ?
+			(unsigned long)NULL : (unsigned long)sdata->data;
+	}
+
+	return (unsigned long)NULL;
+}
+
+BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, =
sk)
+{
+	if (refcount_inc_not_zero(&sk->sk_refcnt)) {
+		int err;
+
+		err =3D sk_storage_delete(sk, map);
+		sock_put(sk);
+		return err;
+	}
+
+	return -ENOENT;
+}
+
+const struct bpf_map_ops sk_storage_map_ops =3D {
+	.map_alloc_check =3D bpf_sk_storage_map_alloc_check,
+	.map_alloc =3D bpf_sk_storage_map_alloc,
+	.map_free =3D bpf_sk_storage_map_free,
+	.map_get_next_key =3D notsupp_get_next_key,
+	.map_lookup_elem =3D bpf_fd_sk_storage_lookup_elem,
+	.map_update_elem =3D bpf_fd_sk_storage_update_elem,
+	.map_delete_elem =3D bpf_fd_sk_storage_delete_elem,
+	.map_check_btf =3D bpf_sk_storage_map_check_btf,
+};
+
+const struct bpf_func_proto bpf_sk_storage_get_proto =3D {
+	.func		=3D bpf_sk_storage_get,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_PTR_TO_SOCKET,
+	.arg3_type	=3D ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	=3D ARG_ANYTHING,
+};
+
+const struct bpf_func_proto bpf_sk_storage_delete_proto =3D {
+	.func		=3D bpf_sk_storage_delete,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_PTR_TO_SOCKET,
+};
diff --git a/net/core/filter.c b/net/core/filter.c
index 2f88baf39cc2..27b0dc01dc3f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -75,6 +75,7 @@
 #include <net/seg6_local.h>
 #include <net/lwtunnel.h>
 #include <net/ipv6_stubs.h>
+#include <net/bpf_sk_storage.h>
=20
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -5903,6 +5904,9 @@ sk_filter_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 	}
 }
=20
+const struct bpf_func_proto bpf_sk_storage_get_proto __weak;
+const struct bpf_func_proto bpf_sk_storage_delete_proto __weak;
+
 static const struct bpf_func_proto *
 cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -5911,6 +5915,10 @@ cg_skb_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_sk_fullsock:
 		return &bpf_sk_fullsock_proto;
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_proto;
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
@@ -5992,6 +6000,10 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_skb_fib_lookup_proto;
 	case BPF_FUNC_sk_fullsock:
 		return &bpf_sk_fullsock_proto;
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_proto;
 #ifdef CONFIG_XFRM
 	case BPF_FUNC_skb_get_xfrm_state:
 		return &bpf_skb_get_xfrm_state_proto;
diff --git a/net/core/sock.c b/net/core/sock.c
index 443b98d05f1e..9773be724aa9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -137,6 +137,7 @@
=20
 #include <linux/filter.h>
 #include <net/sock_reuseport.h>
+#include <net/bpf_sk_storage.h>
=20
 #include <trace/events/sock.h>
=20
@@ -1709,6 +1710,10 @@ static void __sk_destruct(struct rcu_head *head)
=20
 	sock_disable_timestamp(sk, SK_FLAGS_TIMESTAMP);
=20
+#ifdef CONFIG_BPF_SYSCALL
+	bpf_sk_storage_free(sk);
+#endif
+
 	if (atomic_read(&sk->sk_omem_alloc))
 		pr_debug("%s: optmem leakage (%d bytes) detected\n",
 			 __func__, atomic_read(&sk->sk_omem_alloc));
--=20
2.17.1

