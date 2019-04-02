Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93506C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554C42084B
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="K1ITB/Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDBVAt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:00:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40613 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfDBVAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 17:00:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so3886565plr.7
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2019 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pHE7moWZCCTkPC5CRMNrIUSJxWThF7jbn0njsvODNlI=;
        b=K1ITB/ZtYryQ29Ow01VKz7RsUvnB5baYKX9oAL3i9Xge6ahbb5jDGyT0ObiBafM/+U
         sbdnLJfGV7dF8EVa0nCKLwKSZDBhJo19fxkDn7nTBm1bofM8Bfsq5Y+lXG0x3HVjpmfg
         krGdDMXwFImeJwVE03V5kZJzey0DZ+ortYGqaq1pLay0fZL1Hr7Wn+HdoZZGtzT/dyc+
         HMlALspcrmBa+oXHt5FkqZed9XIHYTheYIS4BLd06FV5BOeURO8PjkpUSsQxoyAdn/57
         aWrfVHdf8rnJ41oFSxN7gCFrvn45zzarFfsEgZyZqq+Layzmj+xUmQIq64RKvEh4eh7O
         DpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHE7moWZCCTkPC5CRMNrIUSJxWThF7jbn0njsvODNlI=;
        b=ZVCsrXSDqQImof5Y6yl7g9aiqfxdhmbmELZy5z9jK5Dr+0MnBWnK6Pr/nSFGSgYzcx
         XYyJZ2+iRc18gdwesfOrQrgxvvEtaYdO4rxMF7V0bBETT7t2cMq+8+1QhGlrRrY2pfVx
         KF83QeR6dR1v+3Hk+vg75uxpvw0YJZ6sLEiDVA+fP+Lv68v/N9Ha/4I+XV5lseW0hII1
         7pUPbvxHZJHRQY9xvBvVWfva9TJfMtZnq8c0EjlqBNplAmFuMAlRfqQISA9BFiCmEl5Z
         gzs9RDyZBd4q60jVv7HT+26LLIxcy2rq6Z5zjomvn+mw9q56OiyffYnRD0rrzqS6D+qS
         ZGnA==
X-Gm-Message-State: APjAAAXqknOvsFMp2C82HEv8iEhUNHSE7TEPyBRrhr/oYF6NOcng5qtI
        +t4lU6dK+bqKWZeJreB8QO59nA==
X-Google-Smtp-Source: APXvYqw44iiu1rTNvVDpF+PUwzZVK+3vuPEbQVTapiGxYaq6gzv9KQc837HTw8u/hDiuN0JSppgSFQ==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr14409719pll.12.1554238848285;
        Tue, 02 Apr 2019 14:00:48 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id o68sm39977606pfi.140.2019.04.02.14.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 14:00:47 -0700 (PDT)
Date:   Tue, 2 Apr 2019 14:00:46 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Petar Penkov <peterpenkov96@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH bpf 5/5] flow_dissector: document BPF flow dissector
 environment
Message-ID: <20190402210046.GI7431@mini-arch.hsd1.ca.comcast.net>
References: <20190401205734.4400-1-sdf@google.com>
 <20190401205734.4400-6-sdf@google.com>
 <CA+DcSEgPWDBW1nnweb8pCeOjeLGj7LRgTei+YO-+JKY2VZDz1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DcSEgPWDBW1nnweb8pCeOjeLGj7LRgTei+YO-+JKY2VZDz1w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/02, Petar Penkov wrote:
> On Mon, Apr 1, 2019 at 1:57 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Short doc on what BPF flow dissector should expect in the input
> > __sk_buff and flow_keys.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../networking/bpf_flow_dissector.txt         | 115 ++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/networking/bpf_flow_dissector.txt
> >
> > diff --git a/Documentation/networking/bpf_flow_dissector.txt b/Documentation/networking/bpf_flow_dissector.txt
> > new file mode 100644
> > index 000000000000..513be8e20afb
> > --- /dev/null
> > +++ b/Documentation/networking/bpf_flow_dissector.txt
> > @@ -0,0 +1,115 @@
> > +==================
> > +BPF Flow Dissector
> > +==================
> > +
> > +Overview
> > +========
> > +
> > +Flow dissector is a routine that parses metadata out of the packets. It's
> > +used in the various places in the networking subsystem (RFS, flow hash, etc).
> > +
> > +BPF flow dissector is an attempt to reimplement C-based flow dissector logic
> > +in BPF to gain all the benefits of BPF verifier (namely, limits on the
> > +number of instructions and tail calls).
> > +
> > +API
> > +===
> > +
> > +BPF flow dissector programs operate on an __sk_buff. However, only the
> > +limited set of fields is allowed: data, data_end and flow_keys. flow_keys
> > +is 'struct bpf_flow_keys' and contains flow dissector input and
> > +output arguments.
> > +
> > +The inputs are:
> > +  * nhoff - initial offset of the networking header
> > +  * thoff - initial offset of the transport header, initialized to nhoff
> > +  * n_proto - L3 protocol type, parsed out of L2 header
> > +
> > +Flow dissector BPF program should fill out the rest of the 'struct
> > +bpf_flow_keys' fields. Input arguments nhoff/thoff/n_proto should be also
> > +adjusted accordingly.
> > +
> > +The return code of the BPF program is either BPF_OK to indicate successful
> > +dissection, or BPF_DROP to indicate parsing error.
> I don't think this is actually enforced. I believe the current code
> just checks if the status is BPF_OK or not, rather than BPF_OK,
> BPF_DROP, or neither.
It's not universally enforced, but some codepaths in the kernel look at
the returned value (e.g. skb_get_poff and eth_get_headlen), so it's
better to set the expectations :-)

> > +
> > +__sk_buff->data
> > +===============
> > +
> > +In the VLAN-less case, this is what the initial state of the BPF flow
> > +dissector looks like:
> > ++------+------+------------+-----------+
> > +| DMAC | SMAC | ETHER_TYPE | L3_HEADER |
> > ++------+------+------------+-----------+
> > +                            ^
> > +                            |
> > +                            +-- flow dissector starts here
> > +
> > +skb->data + flow_keys->nhoff point to the first byte of L3_HEADER.
> > +flow_keys->thoff = nhoff
> > +flow_keys->n_proto = ETHER_TYPE
> > +
> > +
> > +In case of VLAN, flow dissector can be called with the two different states.
> > +
> > +Pre-VLAN parsing:
> > ++------+------+------+-----+-----------+-----------+
> > +| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
> > ++------+------+------+-----+-----------+-----------+
> > +                      ^
> > +                      |
> > +                      +-- flow dissector starts here
> > +
> > +skb->data + flow_keys->nhoff point the to first byte of TCI.
> > +flow_keys->thoff = nhoff
> > +flow_keys->n_proto = TPID
> > +
> > +Please note that TPID can be 802.1AD and, hence, BPF program would
> > +have to parse VLAN information twice for double tagged packets.
> > +
> > +
> > +Post-VLAN parsing:
> > ++------+------+------+-----+-----------+-----------+
> > +| DMAC | SMAC | TPID | TCI |ETHER_TYPE | L3_HEADER |
> > ++------+------+------+-----+-----------+-----------+
> > +                                        ^
> > +                                        |
> > +                                        +-- flow dissector starts here
> > +
> > +skb->data + flow_keys->nhoff point the to first byte of L3_HEADER.
> > +flow_keys->thoff = nhoff
> > +flow_keys->n_proto = ETHER_TYPE
> > +
> > +In this case VLAN information has been processed before the flow dissector
> > +and BPF flow dissector is not required to handle it.
> > +
> > +
> > +The takeaway here is as follows: BPF flow dissector program can be called with
> > +the optional VLAN header and should gracefully handle both cases: when single
> > +or double VLAN is present and when it is not present. The same program
> > +can be called for both cases and would have to be written carefully to
> > +handle both cases.
> > +
> > +
> > +Reference Implementation
> > +========================
> > +
> > +See tools/testing/selftests/bpf/progs/bpf_flow.c for the reference
> > +implementation and tools/testing/selftests/bpf/flow_dissector_load.[hc] for
> > +the loader. bpftool can be used to load BPF flow dissector program as well.
> > +
> > +The reference implementation is organized as follows:
> > +* jmp_table map that contains sub-programs for each supported L3 protocol
> > +* _dissect routine - entry point; it does input n_proto parsing and does
> > +  bpf_tail_call to the appropriate L3 handler
> > +
> > +Since BPF at this point doesn't support looping (or any jumping back),
> > +jmp_table is used instead to handle multiple levels of encapsulation (and
> > +IPv6 options).
> > +
> > +
> > +Current Limitations
> > +===================
> > +BPF flow dissector doesn't support exporting all the metadata that in-kernel
> > +C-based implementation can export. Notable example is single VLAN (802.1Q)
> > +and double VLAN (802.1AD) tags. Please refer to the 'struct bpf_flow_keys'
> > +for a set of information that's currently can be exported from the BPF context.
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
