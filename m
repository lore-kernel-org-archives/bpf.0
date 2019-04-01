Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFBDC43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE60208E4
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPTIgcN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfDAU5u (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:57:50 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:47412 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfDAU5u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 16:57:50 -0400
Received: by mail-vk1-f202.google.com with SMTP id l11so5495761vkl.14
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t6QR9vIQXRLcPI1RGVNVDsOCAaM45LnPAHzZuwRpXsA=;
        b=lPTIgcN7TRB6DXtBaAdrQ4IkgnvNi1qbokVs/hfpqu2luGzVNm5Lobe6IGosyNBaPr
         hs9FHVJ2HJw3Qb4uBwJXIZwZ4pNzpXC39/LT/dWajJH1ixYD008AuMn1ZP3ckAchZDse
         am91xW5e0qly4P8iZikaJmZnEEdBWwopqd8asoiCFj+vcivUYKENicnEajgWKLOC6V2+
         wTHkKU8N5kToBSHLSCKcc8YdbzKmjQYLRgRE54F4qMYHolSYb1pjOjWCCCZAgSyQ14Af
         LPRLtFCbWdKW7V68RWWepSsc2MBOy018CePYthj35QVnitB8wkkZa32V1QcC+VT2wxyz
         0rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t6QR9vIQXRLcPI1RGVNVDsOCAaM45LnPAHzZuwRpXsA=;
        b=k4LtnLzewRZLAcFKyTcprTcAY9e/X/sbbBbRY1dQG+DnKF/YserwnrvIALHzIvDldG
         HmvMUkIZrlyOnLOBdU+V8lG7TVzLygQhnzlJma3aaApnTtRn3mztH4Sa/ERq2ODoG9Qd
         Jv1B66s2emLAfQoiCKDFb1fpDLJ65HgHxe+L9AHre9gFcsqFXBu8mLOxGElsYa0E/5fk
         xxlpUMfa7BCmKOSO1Fvy1NB7GozsOWqLcG+iXgr8NF3UuGsD4aW1inLH6skol+/Fyllq
         YHkQFMwtxDt+KHt+pRtgOtgrXeDADSFNCdlSG0RooWmQABkEArwIkTbwa4YUlgDufofO
         Nr+g==
X-Gm-Message-State: APjAAAW4R36S4cdsMxYOZBJ96j9lxc/IJD/a4QkOLpsrXolsQrXEtfFc
        lRyM/Y+pjaLSwcpZnD/w+PHGrH8=
X-Google-Smtp-Source: APXvYqyOQvo5lUhes1uQi1ZJC9keLUxYjwzvHP2Jkv2jgCCSOST+PrHYW4VAHW71SLuuOMa1efnt9nc=
X-Received: by 2002:a67:ed47:: with SMTP id m7mr6840205vsp.26.1554152269150;
 Mon, 01 Apr 2019 13:57:49 -0700 (PDT)
Date:   Mon,  1 Apr 2019 13:57:34 -0700
In-Reply-To: <20190401205734.4400-1-sdf@google.com>
Message-Id: <20190401205734.4400-6-sdf@google.com>
Mime-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf 5/5] flow_dissector: document BPF flow dissector environment
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Short doc on what BPF flow dissector should expect in the input
__sk_buff and flow_keys.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../networking/bpf_flow_dissector.txt         | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/networking/bpf_flow_dissector.txt

diff --git a/Documentation/networking/bpf_flow_dissector.txt b/Documentation/networking/bpf_flow_dissector.txt
new file mode 100644
index 000000000000..513be8e20afb
--- /dev/null
+++ b/Documentation/networking/bpf_flow_dissector.txt
@@ -0,0 +1,115 @@
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
+BPF flow dissector programs operate on an __sk_buff. However, only the
+limited set of fields is allowed: data, data_end and flow_keys. flow_keys
+is 'struct bpf_flow_keys' and contains flow dissector input and
+output arguments.
+
+The inputs are:
+  * nhoff - initial offset of the networking header
+  * thoff - initial offset of the transport header, initialized to nhoff
+  * n_proto - L3 protocol type, parsed out of L2 header
+
+Flow dissector BPF program should fill out the rest of the 'struct
+bpf_flow_keys' fields. Input arguments nhoff/thoff/n_proto should be also
+adjusted accordingly.
+
+The return code of the BPF program is either BPF_OK to indicate successful
+dissection, or BPF_DROP to indicate parsing error.
+
+__sk_buff->data
+===============
+
+In the VLAN-less case, this is what the initial state of the BPF flow
+dissector looks like:
++------+------+------------+-----------+
+| DMAC | SMAC | ETHER_TYPE | L3_HEADER |
++------+------+------------+-----------+
+                            ^
+                            |
+                            +-- flow dissector starts here
+
+skb->data + flow_keys->nhoff point to the first byte of L3_HEADER.
+flow_keys->thoff = nhoff
+flow_keys->n_proto = ETHER_TYPE
+
+
+In case of VLAN, flow dissector can be called with the two different states.
+
+Pre-VLAN parsing:
++------+------+------+-----+-----------+-----------+
+| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
++------+------+------+-----+-----------+-----------+
+                      ^
+                      |
+                      +-- flow dissector starts here
+
+skb->data + flow_keys->nhoff point the to first byte of TCI.
+flow_keys->thoff = nhoff
+flow_keys->n_proto = TPID
+
+Please note that TPID can be 802.1AD and, hence, BPF program would
+have to parse VLAN information twice for double tagged packets.
+
+
+Post-VLAN parsing:
++------+------+------+-----+-----------+-----------+
+| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
++------+------+------+-----+-----------+-----------+
+                                        ^
+                                        |
+                                        +-- flow dissector starts here
+
+skb->data + flow_keys->nhoff point the to first byte of L3_HEADER.
+flow_keys->thoff = nhoff
+flow_keys->n_proto = ETHER_TYPE
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
+See tools/testing/selftests/bpf/progs/bpf_flow.c for the reference
+implementation and tools/testing/selftests/bpf/flow_dissector_load.[hc] for
+the loader. bpftool can be used to load BPF flow dissector program as well.
+
+The reference implementation is organized as follows:
+* jmp_table map that contains sub-programs for each supported L3 protocol
+* _dissect routine - entry point; it does input n_proto parsing and does
+  bpf_tail_call to the appropriate L3 handler
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
+and double VLAN (802.1AD) tags. Please refer to the 'struct bpf_flow_keys'
+for a set of information that's currently can be exported from the BPF context.
-- 
2.21.0.392.gf8f6787159e-goog

