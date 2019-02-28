Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686A5C10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2572133D
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mm7yz0yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfB1Spg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:45:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731654AbfB1Spf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 13:45:35 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SIYE1N024605
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 10:45:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=d5rJo/01XhdoFlfukXd+/vtJGvsxklXx6ErXVuV1lXo=;
 b=mm7yz0yhS63s/bFGASswFfr+8iieHcX9AclnxSqfM6tx8PE5KXlM8x50GEeTS8JZC3po
 mUa9v2R83XY6vc1VU1yNIYZL+TwqBP2pHEMbw6gUEMj1unnVIb8KyY6JMGyfgllvFJ2j
 7v/tCScRGmlHjC7vElBcHhVkNSdWejmR9Oc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxj3x0rwg-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 10:45:34 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 10:45:31 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id B4E15C1290BF; Thu, 28 Feb 2019 10:45:29 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/4] docs/btf: fix typos, improve wording
Date:   Thu, 28 Feb 2019 10:45:09 -0800
Message-ID: <20190228184512.198075-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228184512.198075-1-andriin@fb.com>
References: <20190228184512.198075-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix various typos, some of the formatting and wording for
Documentation/btf.rst.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 Documentation/bpf/btf.rst | 108 +++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 1d434c3a268d..1d761f1c5b2b 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -5,7 +5,7 @@ BPF Type Format (BTF)
 1. Introduction
 ***************
 
-BTF (BPF Type Format) is the meta data format which
+BTF (BPF Type Format) is the metadata format which
 encodes the debug info related to BPF program/map.
 The name BTF was used initially to describe
 data types. The BTF was later extended to include
@@ -40,8 +40,8 @@ details in :ref:`BTF_Type_String`.
 2. BTF Type and String Encoding
 *******************************
 
-The file ``include/uapi/linux/btf.h`` provides high
-level definition on how types/strings are encoded.
+The file ``include/uapi/linux/btf.h`` provides high-level
+definition of how types/strings are encoded.
 
 The beginning of data blob must be::
 
@@ -59,23 +59,23 @@ The beginning of data blob must be::
     };
 
 The magic is ``0xeB9F``, which has different encoding for big and little
-endian system, and can be used to test whether BTF is generated for
-big or little endian target.
-The btf_header is designed to be extensible with hdr_len equal to
-``sizeof(struct btf_header)`` when the data blob is generated.
+endian systems, and can be used to test whether BTF is generated for
+big- or little-endian target.
+The ``btf_header`` is designed to be extensible with ``hdr_len`` equal to
+``sizeof(struct btf_header)`` when a data blob is generated.
 
 2.1 String Encoding
 ===================
 
 The first string in the string section must be a null string.
-The rest of string table is a concatenation of other null-treminated
+The rest of string table is a concatenation of other null-terminated
 strings.
 
 2.2 Type Encoding
 =================
 
 The type id ``0`` is reserved for ``void`` type.
-The type section is parsed sequentially and the type id is assigned to
+The type section is parsed sequentially and type id is assigned to
 each recognized type starting from id ``1``.
 Currently, the following types are supported::
 
@@ -122,9 +122,9 @@ Each type contains the following common data::
         };
     };
 
-For certain kinds, the common data are followed by kind specific data.
-The ``name_off`` in ``struct btf_type`` specifies the offset in the string table.
-The following details encoding of each kind.
+For certain kinds, the common data are followed by kind-specific data.
+The ``name_off`` in ``struct btf_type`` specifies the offset in the string
+table. The following sections detail encoding of each kind.
 
 2.2.1 BTF_KIND_INT
 ~~~~~~~~~~~~~~~~~~
@@ -136,7 +136,7 @@ The following details encoding of each kind.
  * ``info.vlen``: 0
  * ``size``: the size of the int type in bytes.
 
-``btf_type`` is followed by a ``u32`` with following bits arrangement::
+``btf_type`` is followed by a ``u32`` with the following bits arrangement::
 
   #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)
   #define BTF_INT_OFFSET(VAL)     (((VAL  & 0x00ff0000)) >> 16)
@@ -148,7 +148,7 @@ The ``BTF_INT_ENCODING`` has the following attributes::
   #define BTF_INT_CHAR    (1 << 1)
   #define BTF_INT_BOOL    (1 << 2)
 
-The ``BTF_INT_ENCODING()`` provides extra information, signness,
+The ``BTF_INT_ENCODING()`` provides extra information: signedness,
 char, or bool, for the int type. The char and bool encoding
 are mostly useful for pretty print. At most one encoding can
 be specified for the int type.
@@ -161,8 +161,7 @@ The maximum value of ``BTF_INT_BITS()`` is 128.
 
 The ``BTF_INT_OFFSET()`` specifies the starting bit offset to
 calculate values for this int. For example, a bitfield struct
-member has
-
+member has:
  * btf member bit offset 100 from the start of the structure,
  * btf member pointing to an int type,
  * the int type has ``BTF_INT_OFFSET() = 2`` and ``BTF_INT_BITS() = 4``
@@ -179,7 +178,7 @@ access the same bits as the above:
 
 The original intention of ``BTF_INT_OFFSET()`` is to provide
 flexibility of bitfield encoding.
-Currently, both llvm and pahole generates ``BTF_INT_OFFSET() = 0``
+Currently, both llvm and pahole generate ``BTF_INT_OFFSET() = 0``
 for all int types.
 
 2.2.2 BTF_KIND_PTR
@@ -204,7 +203,7 @@ No additional type data follow ``btf_type``.
   * ``info.vlen``: 0
   * ``size/type``: 0, not used
 
-btf_type is followed by one "struct btf_array"::
+``btf_type`` is followed by one ``struct btf_array``::
 
     struct btf_array {
         __u32   type;
@@ -217,27 +216,26 @@ The ``struct btf_array`` encoding:
   * ``index_type``: the index type
   * ``nelems``: the number of elements for this array (``0`` is also allowed).
 
-The ``index_type`` can be any regular int types
-(u8, u16, u32, u64, unsigned __int128).
-The original design of including ``index_type`` follows dwarf
-which has a ``index_type`` for its array type.
+The ``index_type`` can be any regular int type
+(``u8``, ``u16``, ``u32``, ``u64``, ``unsigned __int128``).
+The original design of including ``index_type`` follows DWARF,
+which has an ``index_type`` for its array type.
 Currently in BTF, beyond type verification, the ``index_type`` is not used.
 
 The ``struct btf_array`` allows chaining through element type to represent
-multiple dimensional arrays. For example, ``int a[5][6]``, the following
-type system illustrates the chaining:
+multidimensional arrays. For example, for ``int a[5][6]``, the following
+type information illustrates the chaining:
 
   * [1]: int
   * [2]: array, ``btf_array.type = [1]``, ``btf_array.nelems = 6``
   * [3]: array, ``btf_array.type = [2]``, ``btf_array.nelems = 5``
 
-Currently, both pahole and llvm collapse multiple dimensional array
-into one dimensional array, e.g., ``a[5][6]``, the btf_array.nelems
-equal to ``30``. This is because the original use case is map pretty
-print where the whole array is dumped out so one dimensional array
+Currently, both pahole and llvm collapse multidimensional array
+into one-dimensional array, e.g., for ``a[5][6]``, the ``btf_array.nelems``
+is equal to ``30``. This is because the original use case is map pretty
+print where the whole array is dumped out so one-dimensional array
 is enough. As more BTF usage is explored, pahole and llvm can be
-changed to generate proper chained representation for
-multiple dimensional arrays.
+changed to generate proper chained representation for multidimensional arrays.
 
 2.2.4 BTF_KIND_STRUCT
 ~~~~~~~~~~~~~~~~~~~~~
@@ -382,7 +380,7 @@ No additional type data follow ``btf_type``.
 
 No additional type data follow ``btf_type``.
 
-A BTF_KIND_FUNC defines, not a type, but a subprogram (function) whose
+A BTF_KIND_FUNC defines not a type, but a subprogram (function) whose
 signature is defined by ``type``. The subprogram is thus an instance of
 that type. The BTF_KIND_FUNC may in turn be referenced by a func_info in
 the :ref:`BTF_Ext_Section` (ELF) or in the arguments to
@@ -459,10 +457,10 @@ The workflow typically looks like:
 3.1 BPF_BTF_LOAD
 ================
 
-Load a blob of BTF data into kernel. A blob of data
-described in :ref:`BTF_Type_String`
+Load a blob of BTF data into kernel. A blob of data,
+described in :ref:`BTF_Type_String`,
 can be directly loaded into the kernel.
-A ``btf_fd`` returns to userspace.
+A ``btf_fd`` is returned to a userspace.
 
 3.2 BPF_MAP_CREATE
 ==================
@@ -487,7 +485,7 @@ In libbpf, the map can be defined with extra annotation like below:
 Here, the parameters for macro BPF_ANNOTATE_KV_PAIR are map name,
 key and value types for the map.
 During ELF parsing, libbpf is able to extract key/value type_id's
-and assigned them to BPF_MAP_CREATE attributes automatically.
+and assign them to BPF_MAP_CREATE attributes automatically.
 
 .. _BPF_Prog_Load:
 
@@ -532,7 +530,7 @@ Below are requirements for func_info:
     bpf func boundaries.
 
 Below are requirements for line_info:
-  * the first insn in each func must points to a line_info record.
+  * the first insn in each func must have a line_info record pointing to it.
   * the line_info insn_off is in strictly increasing order.
 
 For line_info, the line number and column number are defined as below:
@@ -544,26 +542,26 @@ For line_info, the line number and column number are defined as below:
 3.4 BPF_{PROG,MAP}_GET_NEXT_ID
 
 In kernel, every loaded program, map or btf has a unique id.
-The id won't change during the life time of the program, map or btf.
+The id won't change during the lifetime of a program, map, or btf.
 
 The bpf syscall command BPF_{PROG,MAP}_GET_NEXT_ID
 returns all id's, one for each command, to user space, for bpf
-program or maps,
-so the inspection tool can inspect all programs and maps.
+program or maps, respectively,
+so an inspection tool can inspect all programs and maps.
 
 3.5 BPF_{PROG,MAP}_GET_FD_BY_ID
 
-The introspection tool cannot use id to get details about program or maps.
-A file descriptor needs to be obtained first for reference counting purpose.
+An introspection tool cannot use id to get details about program or maps.
+A file descriptor needs to be obtained first for reference-counting purpose.
 
 3.6 BPF_OBJ_GET_INFO_BY_FD
 ==========================
 
-Once a program/map fd is acquired, the introspection tool can
+Once a program/map fd is acquired, an introspection tool can
 get the detailed information from kernel about this fd,
-some of which is btf related. For example,
-``bpf_map_info`` returns ``btf_id``, key/value type id.
-``bpf_prog_info`` returns ``btf_id``, func_info and line info
+some of which are BTF-related. For example,
+``bpf_map_info`` returns ``btf_id`` and key/value type ids.
+``bpf_prog_info`` returns ``btf_id``, func_info, and line info
 for translated bpf byte codes, and jited_line_info.
 
 3.7 BPF_BTF_GET_FD_BY_ID
@@ -574,9 +572,9 @@ bpf syscall command BPF_BTF_GET_FD_BY_ID can retrieve a btf fd.
 Then, with command BPF_OBJ_GET_INFO_BY_FD, the btf blob, originally
 loaded into the kernel with BPF_BTF_LOAD, can be retrieved.
 
-With the btf blob, ``bpf_map_info`` and ``bpf_prog_info``, the introspection
+With the btf blob, ``bpf_map_info``, and ``bpf_prog_info``, an introspection
 tool has full btf knowledge and is able to pretty print map key/values,
-dump func signatures, dump line info along with byte/jit codes.
+dump func signatures and line info, along with byte/jit codes.
 
 4. ELF File Format Interface
 ****************************
@@ -625,8 +623,8 @@ The func_info is organized as below.::
      ...
 
 ``func_info_rec_size`` specifies the size of ``bpf_func_info`` structure
-when .BTF.ext is generated. btf_ext_info_sec, defined below, is
-the func_info for each specific ELF section.::
+when .BTF.ext is generated. ``btf_ext_info_sec``, defined below, is
+a collection of func_info for each specific ELF section.::
 
      struct btf_ext_info_sec {
         __u32   sec_name_off; /* offset to section name */
@@ -661,7 +659,7 @@ from the beginning of section (``btf_ext_info_sec->sec_name_off``).
 
 With BTF, the map key/value can be printed based on fields rather than
 simply raw bytes. This is especially
-valuable for large structure or if you data structure
+valuable for large structure or if your data structure
 has bitfields. For example, for the following map,::
 
       enum A { A1, A2, A3, A4, A5 };
@@ -702,8 +700,8 @@ bpftool is able to pretty print like below:
 5.2 bpftool prog dump
 =====================
 
-The following is an example to show func_info and line_info
-can help prog dump with better kernel symbol name, function prototype
+The following is an example showing how func_info and line_info
+can help prog dump with better kernel symbol names, function prototypes
 and line information.::
 
     $ bpftool prog dump jited pinned /sys/fs/bpf/test_btf_haskv
@@ -733,10 +731,10 @@ and line information.::
     ; counts = bpf_map_lookup_elem(&btf_map, &key);
     [...]
 
-5.3 verifier log
+5.3 Verifier Log
 ================
 
-The following is an example how line_info can help verifier failure debug.::
+The following is an example of how line_info can help debugging verification failure.::
 
        /* The code at tools/testing/selftests/bpf/test_xdp_noinline.c
         * is modified as below.
@@ -867,4 +865,4 @@ The assembly code (-S) is able to show the BTF encoding in assembly format.::
 7. Testing
 **********
 
-Kernel bpf selftest `test_btf.c` provides extensive set of BTF related tests.
+Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
-- 
2.17.1

