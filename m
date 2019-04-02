Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE4C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 20:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E412084B
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 20:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrwfWmJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDBUye (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:54:34 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45562 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBUyd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 16:54:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id j128so5112147ywg.12;
        Tue, 02 Apr 2019 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJ5I1sBvjeM/q/+7j8YYGzaldxKFzu4GWoWtSr30Y/Q=;
        b=RrwfWmJWsUWhlEmjE1CkWRQD2V0ldaE7l0zodjF/t2iQS4HMuOa6Or7VTCwdnMnLy9
         XEQUh5SX8owLRlP3Kdt6mphQ48GNjdR+kmTTG/z34FI4YBwUjsDoKMc5czXdxwIYoA8K
         uM/EwE+3k14KvGljyv7EL4rGNdegeiP+TIOR0dcm9KNXyus9y6z3UT0qhl41nVk/FTne
         IWirqV8dyFTgugEcXPqXnCO3s4QMVMU4E1PgrxKABJbtDlPzOCrpSbvh+pw/gArLRrE4
         WISmOZ7DsywFFQNN5YrMbiMfEdC4eRAuUHFz3H/G2A3KQmlDpttR4K6NU1JstDzWUND5
         Mn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJ5I1sBvjeM/q/+7j8YYGzaldxKFzu4GWoWtSr30Y/Q=;
        b=Pvefq9TXWnhdoRIwbSTrAFOYUGIKw8sWRePD8gv+wV7PsWAuOQITlNLpk/4oxlaBIQ
         Q3SCxWgxX/4U/twlEltnlI+SHIJb0MR4gFOqm9S4f82Stv3m/cqtg8TVvKC1m2LBM4Im
         43FWmwwLBd4EdEwoABxSIej4ynUHK0mfRmdvmQmbBZtoZA3CrjIQzpGbnAFvtAEjcjuQ
         xfrpo1ofx6euLZvvO2ex7TjyblKlSI15bfQ8dc0gCiJLqV9yKLdbzC5s0bp93LpKSnfA
         /nFP/P/atvln5pPJzNR1WGkfTukTnk96TYz1zQbF3O63fNrNGlueCB8OY3cxiOsUTTd6
         8dNA==
X-Gm-Message-State: APjAAAWDgCpGIcxjUqt7rO4lyi63XM/BuFAbCnoBfuRJd4PQbDCAbTEX
        LsBbURDGfWZKldYOcm7R1IljHd73MXHKVQbkjgeknmpB
X-Google-Smtp-Source: APXvYqyMODKC0lVHGu35IZ70Hfmq4zyPoSmy16OgJIhMVPCECWU78KF6YIk/LO8e7FTHyzyMZJftryW1Hp+wzKVz0B8=
X-Received: by 2002:a0d:e252:: with SMTP id l79mr59247116ywe.248.1554238472534;
 Tue, 02 Apr 2019 13:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com> <20190401205734.4400-6-sdf@google.com>
In-Reply-To: <20190401205734.4400-6-sdf@google.com>
From:   Petar Penkov <peterpenkov96@gmail.com>
Date:   Tue, 2 Apr 2019 13:54:21 -0700
Message-ID: <CA+DcSEgPWDBW1nnweb8pCeOjeLGj7LRgTei+YO-+JKY2VZDz1w@mail.gmail.com>
Subject: Re: [PATCH bpf 5/5] flow_dissector: document BPF flow dissector environment
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 1, 2019 at 1:57 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Short doc on what BPF flow dissector should expect in the input
> __sk_buff and flow_keys.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  .../networking/bpf_flow_dissector.txt         | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/networking/bpf_flow_dissector.txt
>
> diff --git a/Documentation/networking/bpf_flow_dissector.txt b/Documentation/networking/bpf_flow_dissector.txt
> new file mode 100644
> index 000000000000..513be8e20afb
> --- /dev/null
> +++ b/Documentation/networking/bpf_flow_dissector.txt
> @@ -0,0 +1,115 @@
> +==================
> +BPF Flow Dissector
> +==================
> +
> +Overview
> +========
> +
> +Flow dissector is a routine that parses metadata out of the packets. It's
> +used in the various places in the networking subsystem (RFS, flow hash, etc).
> +
> +BPF flow dissector is an attempt to reimplement C-based flow dissector logic
> +in BPF to gain all the benefits of BPF verifier (namely, limits on the
> +number of instructions and tail calls).
> +
> +API
> +===
> +
> +BPF flow dissector programs operate on an __sk_buff. However, only the
> +limited set of fields is allowed: data, data_end and flow_keys. flow_keys
> +is 'struct bpf_flow_keys' and contains flow dissector input and
> +output arguments.
> +
> +The inputs are:
> +  * nhoff - initial offset of the networking header
> +  * thoff - initial offset of the transport header, initialized to nhoff
> +  * n_proto - L3 protocol type, parsed out of L2 header
> +
> +Flow dissector BPF program should fill out the rest of the 'struct
> +bpf_flow_keys' fields. Input arguments nhoff/thoff/n_proto should be also
> +adjusted accordingly.
> +
> +The return code of the BPF program is either BPF_OK to indicate successful
> +dissection, or BPF_DROP to indicate parsing error.
I don't think this is actually enforced. I believe the current code
just checks if the status is BPF_OK or not, rather than BPF_OK,
BPF_DROP, or neither.

> +
> +__sk_buff->data
> +===============
> +
> +In the VLAN-less case, this is what the initial state of the BPF flow
> +dissector looks like:
> ++------+------+------------+-----------+
> +| DMAC | SMAC | ETHER_TYPE | L3_HEADER |
> ++------+------+------------+-----------+
> +                            ^
> +                            |
> +                            +-- flow dissector starts here
> +
> +skb->data + flow_keys->nhoff point to the first byte of L3_HEADER.
> +flow_keys->thoff = nhoff
> +flow_keys->n_proto = ETHER_TYPE
> +
> +
> +In case of VLAN, flow dissector can be called with the two different states.
> +
> +Pre-VLAN parsing:
> ++------+------+------+-----+-----------+-----------+
> +| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
> ++------+------+------+-----+-----------+-----------+
> +                      ^
> +                      |
> +                      +-- flow dissector starts here
> +
> +skb->data + flow_keys->nhoff point the to first byte of TCI.
> +flow_keys->thoff = nhoff
> +flow_keys->n_proto = TPID
> +
> +Please note that TPID can be 802.1AD and, hence, BPF program would
> +have to parse VLAN information twice for double tagged packets.
> +
> +
> +Post-VLAN parsing:
> ++------+------+------+-----+-----------+-----------+
> +| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
> ++------+------+------+-----+-----------+-----------+
> +                                        ^
> +                                        |
> +                                        +-- flow dissector starts here
> +
> +skb->data + flow_keys->nhoff point the to first byte of L3_HEADER.
> +flow_keys->thoff = nhoff
> +flow_keys->n_proto = ETHER_TYPE
> +
> +In this case VLAN information has been processed before the flow dissector
> +and BPF flow dissector is not required to handle it.
> +
> +
> +The takeaway here is as follows: BPF flow dissector program can be called with
> +the optional VLAN header and should gracefully handle both cases: when single
> +or double VLAN is present and when it is not present. The same program
> +can be called for both cases and would have to be written carefully to
> +handle both cases.
> +
> +
> +Reference Implementation
> +========================
> +
> +See tools/testing/selftests/bpf/progs/bpf_flow.c for the reference
> +implementation and tools/testing/selftests/bpf/flow_dissector_load.[hc] for
> +the loader. bpftool can be used to load BPF flow dissector program as well.
> +
> +The reference implementation is organized as follows:
> +* jmp_table map that contains sub-programs for each supported L3 protocol
> +* _dissect routine - entry point; it does input n_proto parsing and does
> +  bpf_tail_call to the appropriate L3 handler
> +
> +Since BPF at this point doesn't support looping (or any jumping back),
> +jmp_table is used instead to handle multiple levels of encapsulation (and
> +IPv6 options).
> +
> +
> +Current Limitations
> +===================
> +BPF flow dissector doesn't support exporting all the metadata that in-kernel
> +C-based implementation can export. Notable example is single VLAN (802.1Q)
> +and double VLAN (802.1AD) tags. Please refer to the 'struct bpf_flow_keys'
> +for a set of information that's currently can be exported from the BPF context.
> --
> 2.21.0.392.gf8f6787159e-goog
>
