Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12751C10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA87F2133D
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ACfvwVfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfB1SrI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:47:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfB1SrH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 13:47:07 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SIYGdx024620
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 10:47:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=SWhRNb/VBy6BK6/eGyMi5nWE0jJ1HMx4VdYUtckre1M=;
 b=ACfvwVfI5hwqyMv8VZHIJKq8JHjxBcZ9f5ncIbx8EkNy1H+DLV35KsTZRbqX79BhaZIr
 bHnN1Fz4SHYIdJ0D6ZxLnCkY8GztDdYSvHg7YmH7oyIVezAbhfUXzZDz/joXOnS+GWc5
 0jAp8+Bg/lFUpfuSo//ZEKZZlvBYFC0+XzM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxj3x0s0c-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 10:47:04 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 10:45:30 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id B9B57C1290C1; Thu, 28 Feb 2019 10:45:29 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/4] docs/btf: reflow text to fill up to 78 characters
Date:   Thu, 28 Feb 2019 10:45:10 -0800
Message-ID: <20190228184512.198075-3-andriin@fb.com>
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

Reflow paragraphs to more fully and evenly fill 78 character lines.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 Documentation/bpf/btf.rst | 300 ++++++++++++++++++--------------------
 1 file changed, 140 insertions(+), 160 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 1d761f1c5b2b..9a60a5d60e38 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -5,43 +5,35 @@ BPF Type Format (BTF)
 1. Introduction
 ***************
 
-BTF (BPF Type Format) is the metadata format which
-encodes the debug info related to BPF program/map.
-The name BTF was used initially to describe
-data types. The BTF was later extended to include
-function info for defined subroutines, and line info
-for source/line information.
-
-The debug info is used for map pretty print, function
-signature, etc. The function signature enables better
-bpf program/function kernel symbol.
-The line info helps generate
-source annotated translated byte code, jited code
-and verifier log.
+BTF (BPF Type Format) is the metadata format which encodes the debug info
+related to BPF program/map. The name BTF was used initially to describe data
+types. The BTF was later extended to include function info for defined
+subroutines, and line info for source/line information.
+
+The debug info is used for map pretty print, function signature, etc. The
+function signature enables better bpf program/function kernel symbol. The line
+info helps generate source annotated translated byte code, jited code and
+verifier log.
 
 The BTF specification contains two parts,
   * BTF kernel API
   * BTF ELF file format
 
-The kernel API is the contract between
-user space and kernel. The kernel verifies
-the BTF info before using it.
-The ELF file format is a user space contract
-between ELF file and libbpf loader.
+The kernel API is the contract between user space and kernel. The kernel
+verifies the BTF info before using it. The ELF file format is a user space
+contract between ELF file and libbpf loader.
 
-The type and string sections are part of the
-BTF kernel API, describing the debug info
-(mostly types related) referenced by the bpf program.
-These two sections are discussed in
-details in :ref:`BTF_Type_String`.
+The type and string sections are part of the BTF kernel API, describing the
+debug info (mostly types related) referenced by the bpf program. These two
+sections are discussed in details in :ref:`BTF_Type_String`.
 
 .. _BTF_Type_String:
 
 2. BTF Type and String Encoding
 *******************************
 
-The file ``include/uapi/linux/btf.h`` provides high-level
-definition of how types/strings are encoded.
+The file ``include/uapi/linux/btf.h`` provides high-level definition of how
+types/strings are encoded.
 
 The beginning of data blob must be::
 
@@ -59,25 +51,23 @@ The beginning of data blob must be::
     };
 
 The magic is ``0xeB9F``, which has different encoding for big and little
-endian systems, and can be used to test whether BTF is generated for
-big- or little-endian target.
-The ``btf_header`` is designed to be extensible with ``hdr_len`` equal to
-``sizeof(struct btf_header)`` when a data blob is generated.
+endian systems, and can be used to test whether BTF is generated for big- or
+little-endian target. The ``btf_header`` is designed to be extensible with
+``hdr_len`` equal to ``sizeof(struct btf_header)`` when a data blob is
+generated.
 
 2.1 String Encoding
 ===================
 
-The first string in the string section must be a null string.
-The rest of string table is a concatenation of other null-terminated
-strings.
+The first string in the string section must be a null string. The rest of
+string table is a concatenation of other null-terminated strings.
 
 2.2 Type Encoding
 =================
 
-The type id ``0`` is reserved for ``void`` type.
-The type section is parsed sequentially and type id is assigned to
-each recognized type starting from id ``1``.
-Currently, the following types are supported::
+The type id ``0`` is reserved for ``void`` type. The type section is parsed
+sequentially and type id is assigned to each recognized type starting from id
+``1``. Currently, the following types are supported::
 
     #define BTF_KIND_INT            1       /* Integer      */
     #define BTF_KIND_PTR            2       /* Pointer      */
@@ -122,9 +112,9 @@ Each type contains the following common data::
         };
     };
 
-For certain kinds, the common data are followed by kind-specific data.
-The ``name_off`` in ``struct btf_type`` specifies the offset in the string
-table. The following sections detail encoding of each kind.
+For certain kinds, the common data are followed by kind-specific data. The
+``name_off`` in ``struct btf_type`` specifies the offset in the string table.
+The following sections detail encoding of each kind.
 
 2.2.1 BTF_KIND_INT
 ~~~~~~~~~~~~~~~~~~
@@ -148,38 +138,33 @@ The ``BTF_INT_ENCODING`` has the following attributes::
   #define BTF_INT_CHAR    (1 << 1)
   #define BTF_INT_BOOL    (1 << 2)
 
-The ``BTF_INT_ENCODING()`` provides extra information: signedness,
-char, or bool, for the int type. The char and bool encoding
-are mostly useful for pretty print. At most one encoding can
-be specified for the int type.
-
-The ``BTF_INT_BITS()`` specifies the number of actual bits held by
-this int type. For example, a 4-bit bitfield encodes
-``BTF_INT_BITS()`` equals to 4. The ``btf_type.size * 8``
-must be equal to or greater than ``BTF_INT_BITS()`` for the type.
-The maximum value of ``BTF_INT_BITS()`` is 128.
-
-The ``BTF_INT_OFFSET()`` specifies the starting bit offset to
-calculate values for this int. For example, a bitfield struct
-member has:
- * btf member bit offset 100 from the start of the structure,
- * btf member pointing to an int type,
- * the int type has ``BTF_INT_OFFSET() = 2`` and ``BTF_INT_BITS() = 4``
+The ``BTF_INT_ENCODING()`` provides extra information: signedness, char, or
+bool, for the int type. The char and bool encoding are mostly useful for
+pretty print. At most one encoding can be specified for the int type.
+
+The ``BTF_INT_BITS()`` specifies the number of actual bits held by this int
+type. For example, a 4-bit bitfield encodes ``BTF_INT_BITS()`` equals to 4.
+The ``btf_type.size * 8`` must be equal to or greater than ``BTF_INT_BITS()``
+for the type. The maximum value of ``BTF_INT_BITS()`` is 128.
+
+The ``BTF_INT_OFFSET()`` specifies the starting bit offset to calculate values
+for this int. For example, a bitfield struct member has: * btf member bit
+offset 100 from the start of the structure, * btf member pointing to an int
+type, * the int type has ``BTF_INT_OFFSET() = 2`` and ``BTF_INT_BITS() = 4``
 
-Then in the struct memory layout, this member will occupy
-``4`` bits starting from bits ``100 + 2 = 102``.
+Then in the struct memory layout, this member will occupy ``4`` bits starting
+from bits ``100 + 2 = 102``.
 
-Alternatively, the bitfield struct member can be the following to
-access the same bits as the above:
+Alternatively, the bitfield struct member can be the following to access the
+same bits as the above:
 
  * btf member bit offset 102,
  * btf member pointing to an int type,
  * the int type has ``BTF_INT_OFFSET() = 0`` and ``BTF_INT_BITS() = 4``
 
-The original intention of ``BTF_INT_OFFSET()`` is to provide
-flexibility of bitfield encoding.
-Currently, both llvm and pahole generate ``BTF_INT_OFFSET() = 0``
-for all int types.
+The original intention of ``BTF_INT_OFFSET()`` is to provide flexibility of
+bitfield encoding. Currently, both llvm and pahole generate
+``BTF_INT_OFFSET() = 0`` for all int types.
 
 2.2.2 BTF_KIND_PTR
 ~~~~~~~~~~~~~~~~~~
@@ -216,26 +201,25 @@ The ``struct btf_array`` encoding:
   * ``index_type``: the index type
   * ``nelems``: the number of elements for this array (``0`` is also allowed).
 
-The ``index_type`` can be any regular int type
-(``u8``, ``u16``, ``u32``, ``u64``, ``unsigned __int128``).
-The original design of including ``index_type`` follows DWARF,
-which has an ``index_type`` for its array type.
+The ``index_type`` can be any regular int type (``u8``, ``u16``, ``u32``,
+``u64``, ``unsigned __int128``). The original design of including
+``index_type`` follows DWARF, which has an ``index_type`` for its array type.
 Currently in BTF, beyond type verification, the ``index_type`` is not used.
 
 The ``struct btf_array`` allows chaining through element type to represent
-multidimensional arrays. For example, for ``int a[5][6]``, the following
-type information illustrates the chaining:
+multidimensional arrays. For example, for ``int a[5][6]``, the following type
+information illustrates the chaining:
 
   * [1]: int
   * [2]: array, ``btf_array.type = [1]``, ``btf_array.nelems = 6``
   * [3]: array, ``btf_array.type = [2]``, ``btf_array.nelems = 5``
 
-Currently, both pahole and llvm collapse multidimensional array
-into one-dimensional array, e.g., for ``a[5][6]``, the ``btf_array.nelems``
-is equal to ``30``. This is because the original use case is map pretty
-print where the whole array is dumped out so one-dimensional array
-is enough. As more BTF usage is explored, pahole and llvm can be
-changed to generate proper chained representation for multidimensional arrays.
+Currently, both pahole and llvm collapse multidimensional array into
+one-dimensional array, e.g., for ``a[5][6]``, the ``btf_array.nelems`` is
+equal to ``30``. This is because the original use case is map pretty print
+where the whole array is dumped out so one-dimensional array is enough. As
+more BTF usage is explored, pahole and llvm can be changed to generate proper
+chained representation for multidimensional arrays.
 
 2.2.4 BTF_KIND_STRUCT
 ~~~~~~~~~~~~~~~~~~~~~
@@ -262,28 +246,26 @@ changed to generate proper chained representation for multidimensional arrays.
   * ``type``: the member type
   * ``offset``: <see below>
 
-If the type info ``kind_flag`` is not set, the offset contains
-only bit offset of the member. Note that the base type of the
-bitfield can only be int or enum type. If the bitfield size
-is 32, the base type can be either int or enum type.
-If the bitfield size is not 32, the base type must be int,
-and int type ``BTF_INT_BITS()`` encodes the bitfield size.
+If the type info ``kind_flag`` is not set, the offset contains only bit offset
+of the member. Note that the base type of the bitfield can only be int or enum
+type. If the bitfield size is 32, the base type can be either int or enum
+type. If the bitfield size is not 32, the base type must be int, and int type
+``BTF_INT_BITS()`` encodes the bitfield size.
 
-If the ``kind_flag`` is set, the ``btf_member.offset``
-contains both member bitfield size and bit offset. The
-bitfield size and bit offset are calculated as below.::
+If the ``kind_flag`` is set, the ``btf_member.offset`` contains both member
+bitfield size and bit offset. The bitfield size and bit offset are calculated
+as below.::
 
   #define BTF_MEMBER_BITFIELD_SIZE(val)   ((val) >> 24)
   #define BTF_MEMBER_BIT_OFFSET(val)      ((val) & 0xffffff)
 
-In this case, if the base type is an int type, it must
-be a regular int type:
+In this case, if the base type is an int type, it must be a regular int type:
 
   * ``BTF_INT_OFFSET()`` must be 0.
   * ``BTF_INT_BITS()`` must be equal to ``{1,2,4,8,16} * 8``.
 
-The following kernel patch introduced ``kind_flag`` and
-explained why both modes exist:
+The following kernel patch introduced ``kind_flag`` and explained why both
+modes exist:
 
   https://github.com/torvalds/linux/commit/9d5f9f701b1891466fb3dbb1806ad97716f95cc3#diff-fa650a64fdd3968396883d2fe8215ff3
 
@@ -381,10 +363,10 @@ No additional type data follow ``btf_type``.
 No additional type data follow ``btf_type``.
 
 A BTF_KIND_FUNC defines not a type, but a subprogram (function) whose
-signature is defined by ``type``. The subprogram is thus an instance of
-that type. The BTF_KIND_FUNC may in turn be referenced by a func_info in
-the :ref:`BTF_Ext_Section` (ELF) or in the arguments to
-:ref:`BPF_Prog_Load` (ABI).
+signature is defined by ``type``. The subprogram is thus an instance of that
+type. The BTF_KIND_FUNC may in turn be referenced by a func_info in the
+:ref:`BTF_Ext_Section` (ELF) or in the arguments to :ref:`BPF_Prog_Load`
+(ABI).
 
 2.2.13 BTF_KIND_FUNC_PROTO
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -403,13 +385,13 @@ the :ref:`BTF_Ext_Section` (ELF) or in the arguments to
         __u32   type;
     };
 
-If a BTF_KIND_FUNC_PROTO type is referred by a BTF_KIND_FUNC type,
-then ``btf_param.name_off`` must point to a valid C identifier
-except for the possible last argument representing the variable
-argument. The btf_param.type refers to parameter type.
+If a BTF_KIND_FUNC_PROTO type is referred by a BTF_KIND_FUNC type, then
+``btf_param.name_off`` must point to a valid C identifier except for the
+possible last argument representing the variable argument. The btf_param.type
+refers to parameter type.
 
-If the function has variable arguments, the last parameter
-is encoded with ``name_off = 0`` and ``type = 0``.
+If the function has variable arguments, the last parameter is encoded with
+``name_off = 0`` and ``type = 0``.
 
 3. BTF Kernel API
 *****************
@@ -457,10 +439,9 @@ The workflow typically looks like:
 3.1 BPF_BTF_LOAD
 ================
 
-Load a blob of BTF data into kernel. A blob of data,
-described in :ref:`BTF_Type_String`,
-can be directly loaded into the kernel.
-A ``btf_fd`` is returned to a userspace.
+Load a blob of BTF data into kernel. A blob of data, described in
+:ref:`BTF_Type_String`, can be directly loaded into the kernel. A ``btf_fd``
+is returned to a userspace.
 
 3.2 BPF_MAP_CREATE
 ==================
@@ -482,18 +463,18 @@ In libbpf, the map can be defined with extra annotation like below:
     };
     BPF_ANNOTATE_KV_PAIR(btf_map, int, struct ipv_counts);
 
-Here, the parameters for macro BPF_ANNOTATE_KV_PAIR are map name,
-key and value types for the map.
-During ELF parsing, libbpf is able to extract key/value type_id's
-and assign them to BPF_MAP_CREATE attributes automatically.
+Here, the parameters for macro BPF_ANNOTATE_KV_PAIR are map name, key and
+value types for the map. During ELF parsing, libbpf is able to extract
+key/value type_id's and assign them to BPF_MAP_CREATE attributes
+automatically.
 
 .. _BPF_Prog_Load:
 
 3.3 BPF_PROG_LOAD
 =================
 
-During prog_load, func_info and line_info can be passed to kernel with
-proper values for the following attributes:
+During prog_load, func_info and line_info can be passed to kernel with proper
+values for the following attributes:
 ::
 
     __u32           insn_cnt;
@@ -520,9 +501,9 @@ The func_info and line_info are an array of below, respectively.::
         __u32   line_col; /* line number and column number */
     };
 
-func_info_rec_size is the size of each func_info record, and line_info_rec_size
-is the size of each line_info record. Passing the record size to kernel make
-it possible to extend the record itself in the future.
+func_info_rec_size is the size of each func_info record, and
+line_info_rec_size is the size of each line_info record. Passing the record
+size to kernel make it possible to extend the record itself in the future.
 
 Below are requirements for func_info:
   * func_info[0].insn_off must be 0.
@@ -541,13 +522,12 @@ For line_info, the line number and column number are defined as below:
 
 3.4 BPF_{PROG,MAP}_GET_NEXT_ID
 
-In kernel, every loaded program, map or btf has a unique id.
-The id won't change during the lifetime of a program, map, or btf.
+In kernel, every loaded program, map or btf has a unique id. The id won't
+change during the lifetime of a program, map, or btf.
 
-The bpf syscall command BPF_{PROG,MAP}_GET_NEXT_ID
-returns all id's, one for each command, to user space, for bpf
-program or maps, respectively,
-so an inspection tool can inspect all programs and maps.
+The bpf syscall command BPF_{PROG,MAP}_GET_NEXT_ID returns all id's, one for
+each command, to user space, for bpf program or maps, respectively, so an
+inspection tool can inspect all programs and maps.
 
 3.5 BPF_{PROG,MAP}_GET_FD_BY_ID
 
@@ -557,24 +537,23 @@ A file descriptor needs to be obtained first for reference-counting purpose.
 3.6 BPF_OBJ_GET_INFO_BY_FD
 ==========================
 
-Once a program/map fd is acquired, an introspection tool can
-get the detailed information from kernel about this fd,
-some of which are BTF-related. For example,
-``bpf_map_info`` returns ``btf_id`` and key/value type ids.
-``bpf_prog_info`` returns ``btf_id``, func_info, and line info
-for translated bpf byte codes, and jited_line_info.
+Once a program/map fd is acquired, an introspection tool can get the detailed
+information from kernel about this fd, some of which are BTF-related. For
+example, ``bpf_map_info`` returns ``btf_id`` and key/value type ids.
+``bpf_prog_info`` returns ``btf_id``, func_info, and line info for translated
+bpf byte codes, and jited_line_info.
 
 3.7 BPF_BTF_GET_FD_BY_ID
 ========================
 
-With ``btf_id`` obtained in ``bpf_map_info`` and ``bpf_prog_info``,
-bpf syscall command BPF_BTF_GET_FD_BY_ID can retrieve a btf fd.
-Then, with command BPF_OBJ_GET_INFO_BY_FD, the btf blob, originally
-loaded into the kernel with BPF_BTF_LOAD, can be retrieved.
+With ``btf_id`` obtained in ``bpf_map_info`` and ``bpf_prog_info``, bpf
+syscall command BPF_BTF_GET_FD_BY_ID can retrieve a btf fd. Then, with
+command BPF_OBJ_GET_INFO_BY_FD, the btf blob, originally loaded into the
+kernel with BPF_BTF_LOAD, can be retrieved.
 
 With the btf blob, ``bpf_map_info``, and ``bpf_prog_info``, an introspection
-tool has full btf knowledge and is able to pretty print map key/values,
-dump func signatures and line info, along with byte/jit codes.
+tool has full btf knowledge and is able to pretty print map key/values, dump
+func signatures and line info, along with byte/jit codes.
 
 4. ELF File Format Interface
 ****************************
@@ -582,19 +561,19 @@ dump func signatures and line info, along with byte/jit codes.
 4.1 .BTF section
 ================
 
-The .BTF section contains type and string data. The format of this section
-is same as the one describe in :ref:`BTF_Type_String`.
+The .BTF section contains type and string data. The format of this section is
+same as the one describe in :ref:`BTF_Type_String`.
 
 .. _BTF_Ext_Section:
 
 4.2 .BTF.ext section
 ====================
 
-The .BTF.ext section encodes func_info and line_info which
-needs loader manipulation before loading into the kernel.
+The .BTF.ext section encodes func_info and line_info which needs loader
+manipulation before loading into the kernel.
 
-The specification for .BTF.ext section is defined at
-``tools/lib/bpf/btf.h`` and ``tools/lib/bpf/btf.c``.
+The specification for .BTF.ext section is defined at ``tools/lib/bpf/btf.h``
+and ``tools/lib/bpf/btf.c``.
 
 The current header of .BTF.ext section::
 
@@ -611,9 +590,9 @@ The current header of .BTF.ext section::
         __u32   line_info_len;
     };
 
-It is very similar to .BTF section. Instead of type/string section,
-it contains func_info and line_info section. See :ref:`BPF_Prog_Load`
-for details about func_info and line_info record format.
+It is very similar to .BTF section. Instead of type/string section, it
+contains func_info and line_info section. See :ref:`BPF_Prog_Load` for details
+about func_info and line_info record format.
 
 The func_info is organized as below.::
 
@@ -622,9 +601,9 @@ The func_info is organized as below.::
      btf_ext_info_sec for section #2 /* func_info for section #2 */
      ...
 
-``func_info_rec_size`` specifies the size of ``bpf_func_info`` structure
-when .BTF.ext is generated. ``btf_ext_info_sec``, defined below, is
-a collection of func_info for each specific ELF section.::
+``func_info_rec_size`` specifies the size of ``bpf_func_info`` structure when
+.BTF.ext is generated. ``btf_ext_info_sec``, defined below, is a collection of
+func_info for each specific ELF section.::
 
      struct btf_ext_info_sec {
         __u32   sec_name_off; /* offset to section name */
@@ -642,14 +621,14 @@ The line_info is organized as below.::
      btf_ext_info_sec for section #2 /* line_info for section #2 */
      ...
 
-``line_info_rec_size`` specifies the size of ``bpf_line_info`` structure
-when .BTF.ext is generated.
+``line_info_rec_size`` specifies the size of ``bpf_line_info`` structure when
+.BTF.ext is generated.
 
 The interpretation of ``bpf_func_info->insn_off`` and
-``bpf_line_info->insn_off`` is different between kernel API and ELF API.
-For kernel API, the ``insn_off`` is the instruction offset in the unit
-of ``struct bpf_insn``. For ELF API, the ``insn_off`` is the byte offset
-from the beginning of section (``btf_ext_info_sec->sec_name_off``).
+``bpf_line_info->insn_off`` is different between kernel API and ELF API. For
+kernel API, the ``insn_off`` is the instruction offset in the unit of ``struct
+bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
+beginning of section (``btf_ext_info_sec->sec_name_off``).
 
 5. Using BTF
 ************
@@ -657,10 +636,9 @@ from the beginning of section (``btf_ext_info_sec->sec_name_off``).
 5.1 bpftool map pretty print
 ============================
 
-With BTF, the map key/value can be printed based on fields rather than
-simply raw bytes. This is especially
-valuable for large structure or if your data structure
-has bitfields. For example, for the following map,::
+With BTF, the map key/value can be printed based on fields rather than simply
+raw bytes. This is especially valuable for large structure or if your data
+structure has bitfields. For example, for the following map,::
 
       enum A { A1, A2, A3, A4, A5 };
       typedef enum A ___A;
@@ -700,9 +678,9 @@ bpftool is able to pretty print like below:
 5.2 bpftool prog dump
 =====================
 
-The following is an example showing how func_info and line_info
-can help prog dump with better kernel symbol names, function prototypes
-and line information.::
+The following is an example showing how func_info and line_info can help prog
+dump with better kernel symbol names, function prototypes and line
+information.::
 
     $ bpftool prog dump jited pinned /sys/fs/bpf/test_btf_haskv
     [...]
@@ -734,7 +712,8 @@ and line information.::
 5.3 Verifier Log
 ================
 
-The following is an example of how line_info can help debugging verification failure.::
+The following is an example of how line_info can help debugging verification
+failure.::
 
        /* The code at tools/testing/selftests/bpf/test_xdp_noinline.c
         * is modified as below.
@@ -763,8 +742,8 @@ You need latest pahole
 
   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
 
-or llvm (8.0 or later). The pahole acts as a dwarf2btf converter. It doesn't support .BTF.ext
-and btf BTF_KIND_FUNC type yet. For example,::
+or llvm (8.0 or later). The pahole acts as a dwarf2btf converter. It doesn't
+support .BTF.ext and btf BTF_KIND_FUNC type yet. For example,::
 
       -bash-4.4$ cat t.c
       struct t {
@@ -781,8 +760,9 @@ and btf BTF_KIND_FUNC type yet. For example,::
               c type_id=2 bitfield_size=2 bits_offset=5
       [2] INT int size=4 bit_offset=0 nr_bits=32 encoding=SIGNED
 
-The llvm is able to generate .BTF and .BTF.ext directly with -g for bpf target only.
-The assembly code (-S) is able to show the BTF encoding in assembly format.::
+The llvm is able to generate .BTF and .BTF.ext directly with -g for bpf target
+only. The assembly code (-S) is able to show the BTF encoding in assembly
+format.::
 
     -bash-4.4$ cat t2.c
     typedef int __int32;
-- 
2.17.1

