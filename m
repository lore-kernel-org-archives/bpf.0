Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C80FC4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 20:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A5E2084B
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 20:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="id1I9aO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDCUxW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:53:22 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:45344 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCUxW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 16:53:22 -0400
Received: by mail-ot1-f74.google.com with SMTP id o13so28706otk.12
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2019 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QNr1Kx3YdZof0I1eROS1Ih6yuF5SZuPFhUlYJO2kjpg=;
        b=id1I9aO/RcIgMHF5Q4sTu56HwOmyb5j7ngO3OsJYmYc4tqp1y/fby+jS+QloYjy1nE
         z1Wklq5zeVoOk56zSi6YPmzC1NOnCWWbC2DU7u4dOX7mQapiPOzDPfIHRqoT9B61c4Df
         ScE9WanLlcavh7LLvtFz7clr4z+qrNq3TvZtRBkbRoob6JUODGhwih4oAy385ocY34Ic
         Ud9lJ3PnAeams+he+4IPk+GihbIbIQpIIQwE4LJNjiAwhek44rfveKyp9sj/Ivr347oG
         Y9VmA5ECgvG15vN7ierGXZpFdbBzULMrB8F/xAjZCmuwSvuegDhW038/9WAuFwrQURib
         QDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QNr1Kx3YdZof0I1eROS1Ih6yuF5SZuPFhUlYJO2kjpg=;
        b=FSjulcjxy+5IAylcA4eTpftoP+ZHGYm2vt40ObH3Klg0bJ/PhuUprz0A8FzkE0nFYH
         tt7h/YOym2e1PaGE+o1KvJUjAGUUcBeGalLIC2wWkH2JndXGBEYdUGXAnixvwMvKHV1u
         bhfUJ+MSSb+9jqVrNfCd/tF0X9zNL9xLA8oEdhjVwImiIzl9VAly9YFkD9VzXQGfZqGH
         I2u8cBdR4Cxh+qke2ir/d4NopERE3/rdJfLEazbG2kzLyX4Nx3ybeVu0epv9SkXc06pw
         J3qLA795adhVzVlPZp3S4UgQXl10Lw4bZKfP70HSkkL6S9KVuz4WqC1RnclaBrs/dfAk
         yZlQ==
X-Gm-Message-State: APjAAAXP2xGpEhmTR0OSY+waMMJNU+gVnZOvDYc/cRzuBGod+WHCB9Li
        0fFUOhgB4ASlx0wRStTYiN8E42g=
X-Google-Smtp-Source: APXvYqzak9mLwJ53pEwDB32xZYUJCat6Bc700+BXCEeH5UCsqmkbaOxA9DTlveHPIinQ6ifg41sa+R8=
X-Received: by 2002:a05:6830:112:: with SMTP id i18mr183412otp.50.1554324801088;
 Wed, 03 Apr 2019 13:53:21 -0700 (PDT)
Date:   Wed,  3 Apr 2019 13:53:18 -0700
Message-Id: <20190403205318.123125-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf] flow_dissector: rst'ify documentation
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename bpf_flow_dissector.txt to bpf_flow_dissector.rst and fix
formatting. Also, link it from the Documentation/networking/index.rst.

Tested with 'make htmldocs' to make sure it looks reasonable.

Fixes: ae82899bbe92 ("flow_dissector: document BPF flow dissector environment")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../networking/bpf_flow_dissector.rst         | 126 ++++++++++++++++++
 .../networking/bpf_flow_dissector.txt         | 115 ----------------
 Documentation/networking/index.rst            |   1 +
 3 files changed, 127 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/networking/bpf_flow_dissector.rst
 delete mode 100644 Documentation/networking/bpf_flow_dissector.txt

diff --git a/Documentation/networking/bpf_flow_dissector.rst b/Documentation/networking/bpf_flow_dissector.rst
new file mode 100644
index 000000000000..b375ae2ec2c4
--- /dev/null
+++ b/Documentation/networking/bpf_flow_dissector.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+BPF Flow Dissector
+==================
+
+Overview
+========
+
+Flow dissector is a routine that parses metadata out of the packets. It's
+used in the various places in the networking subsystem (RFS, flow hash, etc).
+
+BPF flow dissector is an attempt to reimplement C-based flow dissector logic
+in BPF to gain all the benefits of BPF verifier (namely, limits on the
+number of instructions and tail calls).
+
+API
+===
+
+BPF flow dissector programs operate on an ``__sk_buff``. However, only the
+limited set of fields is allowed: ``data``, ``data_end`` and ``flow_keys``.
+``flow_keys`` is ``struct bpf_flow_keys`` and contains flow dissector input
+and output arguments.
+
+The inputs are:
+  * ``nhoff`` - initial offset of the networking header
+  * ``thoff`` - initial offset of the transport header, initialized to nhoff
+  * ``n_proto`` - L3 protocol type, parsed out of L2 header
+
+Flow dissector BPF program should fill out the rest of the ``struct
+bpf_flow_keys`` fields. Input arguments ``nhoff/thoff/n_proto`` should be
+also adjusted accordingly.
+
+The return code of the BPF program is either BPF_OK to indicate successful
+dissection, or BPF_DROP to indicate parsing error.
+
+__sk_buff->data
+===============
+
+In the VLAN-less case, this is what the initial state of the BPF flow
+dissector looks like::
+
+  +------+------+------------+-----------+
+  | DMAC | SMAC | ETHER_TYPE | L3_HEADER |
+  +------+------+------------+-----------+
+                              ^
+                              |
+                              +-- flow dissector starts here
+
+
+.. code:: c
+
+  skb->data + flow_keys->nhoff point to the first byte of L3_HEADER
+  flow_keys->thoff = nhoff
+  flow_keys->n_proto = ETHER_TYPE
+
+In case of VLAN, flow dissector can be called with the two different states.
+
+Pre-VLAN parsing::
+
+  +------+------+------+-----+-----------+-----------+
+  | DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
+  +------+------+------+-----+-----------+-----------+
+                        ^
+                        |
+                        +-- flow dissector starts here
+
+.. code:: c
+
+  skb->data + flow_keys->nhoff point the to first byte of TCI
+  flow_keys->thoff = nhoff
+  flow_keys->n_proto = TPID
+
+Please note that TPID can be 802.1AD and, hence, BPF program would
+have to parse VLAN information twice for double tagged packets.
+
+
+Post-VLAN parsing::
+
+  +------+------+------+-----+-----------+-----------+
+  | DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
+  +------+------+------+-----+-----------+-----------+
+                                          ^
+                                          |
+                                          +-- flow dissector starts here
+
+.. code:: c
+
+  skb->data + flow_keys->nhoff point the to first byte of L3_HEADER
+  flow_keys->thoff = nhoff
+  flow_keys->n_proto = ETHER_TYPE
+
+In this case VLAN information has been processed before the flow dissector
+and BPF flow dissector is not required to handle it.
+
+
+The takeaway here is as follows: BPF flow dissector program can be called with
+the optional VLAN header and should gracefully handle both cases: when single
+or double VLAN is present and when it is not present. The same program
+can be called for both cases and would have to be written carefully to
+handle both cases.
+
+
+Reference Implementation
+========================
+
+See ``tools/testing/selftests/bpf/progs/bpf_flow.c`` for the reference
+implementation and ``tools/testing/selftests/bpf/flow_dissector_load.[hc]``
+for the loader. bpftool can be used to load BPF flow dissector program as well.
+
+The reference implementation is organized as follows:
+  * ``jmp_table`` map that contains sub-programs for each supported L3 protocol
+  * ``_dissect`` routine - entry point; it does input ``n_proto`` parsing and
+    does ``bpf_tail_call`` to the appropriate L3 handler
+
+Since BPF at this point doesn't support looping (or any jumping back),
+jmp_table is used instead to handle multiple levels of encapsulation (and
+IPv6 options).
+
+
+Current Limitations
+===================
+BPF flow dissector doesn't support exporting all the metadata that in-kernel
+C-based implementation can export. Notable example is single VLAN (802.1Q)
+and double VLAN (802.1AD) tags. Please refer to the ``struct bpf_flow_keys``
+for a set of information that's currently can be exported from the BPF context.
diff --git a/Documentation/networking/bpf_flow_dissector.txt b/Documentation/networking/bpf_flow_dissector.txt
deleted file mode 100644
index 70f66a2d57e7..000000000000
--- a/Documentation/networking/bpf_flow_dissector.txt
+++ /dev/null
@@ -1,115 +0,0 @@
-==================
-BPF Flow Dissector
-==================
-
-Overview
-========
-
-Flow dissector is a routine that parses metadata out of the packets. It's
-used in the various places in the networking subsystem (RFS, flow hash, etc).
-
-BPF flow dissector is an attempt to reimplement C-based flow dissector logic
-in BPF to gain all the benefits of BPF verifier (namely, limits on the
-number of instructions and tail calls).
-
-API
-===
-
-BPF flow dissector programs operate on an __sk_buff. However, only the
-limited set of fields is allowed: data, data_end and flow_keys. flow_keys
-is 'struct bpf_flow_keys' and contains flow dissector input and
-output arguments.
-
-The inputs are:
-  * nhoff - initial offset of the networking header
-  * thoff - initial offset of the transport header, initialized to nhoff
-  * n_proto - L3 protocol type, parsed out of L2 header
-
-Flow dissector BPF program should fill out the rest of the 'struct
-bpf_flow_keys' fields. Input arguments nhoff/thoff/n_proto should be also
-adjusted accordingly.
-
-The return code of the BPF program is either BPF_OK to indicate successful
-dissection, or BPF_DROP to indicate parsing error.
-
-__sk_buff->data
-===============
-
-In the VLAN-less case, this is what the initial state of the BPF flow
-dissector looks like:
-+------+------+------------+-----------+
-| DMAC | SMAC | ETHER_TYPE | L3_HEADER |
-+------+------+------------+-----------+
-                            ^
-                            |
-                            +-- flow dissector starts here
-
-skb->data + flow_keys->nhoff point to the first byte of L3_HEADER.
-flow_keys->thoff = nhoff
-flow_keys->n_proto = ETHER_TYPE
-
-
-In case of VLAN, flow dissector can be called with the two different states.
-
-Pre-VLAN parsing:
-+------+------+------+-----+-----------+-----------+
-| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
-+------+------+------+-----+-----------+-----------+
-                      ^
-                      |
-                      +-- flow dissector starts here
-
-skb->data + flow_keys->nhoff point the to first byte of TCI.
-flow_keys->thoff = nhoff
-flow_keys->n_proto = TPID
-
-Please note that TPID can be 802.1AD and, hence, BPF program would
-have to parse VLAN information twice for double tagged packets.
-
-
-Post-VLAN parsing:
-+------+------+------+-----+-----------+-----------+
-| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
-+------+------+------+-----+-----------+-----------+
-                                        ^
-                                        |
-                                        +-- flow dissector starts here
-
-skb->data + flow_keys->nhoff point the to first byte of L3_HEADER.
-flow_keys->thoff = nhoff
-flow_keys->n_proto = ETHER_TYPE
-
-In this case VLAN information has been processed before the flow dissector
-and BPF flow dissector is not required to handle it.
-
-
-The takeaway here is as follows: BPF flow dissector program can be called with
-the optional VLAN header and should gracefully handle both cases: when single
-or double VLAN is present and when it is not present. The same program
-can be called for both cases and would have to be written carefully to
-handle both cases.
-
-
-Reference Implementation
-========================
-
-See tools/testing/selftests/bpf/progs/bpf_flow.c for the reference
-implementation and tools/testing/selftests/bpf/flow_dissector_load.[hc] for
-the loader. bpftool can be used to load BPF flow dissector program as well.
-
-The reference implementation is organized as follows:
-* jmp_table map that contains sub-programs for each supported L3 protocol
-* _dissect routine - entry point; it does input n_proto parsing and does
-  bpf_tail_call to the appropriate L3 handler
-
-Since BPF at this point doesn't support looping (or any jumping back),
-jmp_table is used instead to handle multiple levels of encapsulation (and
-IPv6 options).
-
-
-Current Limitations
-===================
-BPF flow dissector doesn't support exporting all the metadata that in-kernel
-C-based implementation can export. Notable example is single VLAN (802.1Q)
-and double VLAN (802.1AD) tags. Please refer to the 'struct bpf_flow_keys'
-for a set of information that's currently can be exported from the BPF context.
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 5449149be496..984e68f9e026 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -9,6 +9,7 @@ Linux Networking Documentation
    netdev-FAQ
    af_xdp
    batman-adv
+   bpf_flow_dissector
    can
    can_ucan_protocol
    device_drivers/freescale/dpaa2/index
-- 
2.21.0.392.gf8f6787159e-goog

