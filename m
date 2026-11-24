Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554148;
	b=ilC395kQgv+4ujbRA3OFHYzpuH8HNHDM+W6UA3j4sP5Kme6u7R/NqWltstJJMs+/g2m0
	 1JsLu+7gLTPH8qsNBtrE17cHgQZuH+2C/C3oR9ft+N0F2nlT9JiKvxlvgsYhuIk86S7YB
	 S940mzFNSHYvBatBF5lsPr0FNywFrJ5C4RRMG1H3gjDs0bdx88QL6Sxk4JgIT6so0VmpH
	 fME+jjsUNCf9wsRnev6wDMxm5qnhqsONw87m4PIc6Fs4p4JGPkNPIUIOgEDSJLoz9wpCs
	 l1uIV6MGmTCg6PGkyTxoR2LhPPldsL5kYqAIQgzWmMLAj1QoXswlC/kdKHyX3Un6dMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=lN0LIdbFRBgoTNvh2FY0WEDqLMBfD1vMRoz0mR1ChNI=;
	b=S9nKIcGpbUTf0bT8KTHnRLLrRDm6lkVZICKIrUHO4WVhXOJ1MbA/8VDdCnBWr/NRRUYP
	 ZMZMDKI1ucJQoWCy7Y8/JtBjR/B05o3TgFRUJizc1jB5OStZsHdVHdxJBxEhXek13s/KL
	 xtFI1XpQEFmuDGu9mP8E80IrqJhTlCvVTe9hFVKZhC2/tQlfkLXPjYQ0Q25uKNwoO67B7
	 shtKZMp9kngpk6EQqMQNmR+8L7/UCJZ/cI0VM1TtzfpT5Y9+yd8lGtJ25OukCa73Zy72N
	 LVhqGIHTmI8/zatvStOsTO7c9EXgbjCz5spkjqkydJhLHkarHnEkcJNMC6YT8Uyvmxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GA1+320B;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF61606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF61606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GA1+320B
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso2643751a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554147; x=1796158947; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lN0LIdbFRBgoTNvh2FY0WEDqLMBfD1vMRoz0mR1ChNI=;
        b=GA1+320B821O1xy60RjnsPaoOs6agEFfkicaceCVePqeMX033v7n36KLO/PvHWIRzG
         //3+nxW+4B5oxveiEjqdwnv5TkUMRNYRqNRoVWe4qeoaHIPWIhRABcxh99Amjmmzio8H
         9tKvRh2n78eifEQr3nJxsc0e7POzW6IHftngXvqOxNnLKr/CtXgkBPlSAufaqIW+C19i
         5ZN5UoO6yS6T3uzb1snWHvuBPYPVmAHjlzxeMhS8kwxqkH6ew80NxqfP8bFpBcUlBUP+
         Lhz6lBrqD23wEn28u1I94D9dHZKMLCTWPNHsLziGoohBoAQTqkUkdDzj6Wh7OSjAsXKu
         AXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554147; x=1796158947;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lN0LIdbFRBgoTNvh2FY0WEDqLMBfD1vMRoz0mR1ChNI=;
        b=u6U0JPj10F+7lRmOxN2CNOwCu2yS+eHvYjuwPyY56aZi5ym5Efb0G6waFkkMxmpIUQ
         286Sfi2NladMNgEnw7/WjXRu2AH7L0ngFt4c9wBZTrj/xOB/UpZWYvNwKxnot2zQk+dp
         qTvUGSmSGzK+8Lx+oWYwKORzhogyzHIhGtc77Sl+XajXkcm9ByHbBFWlgjFq+XPFho6D
         HnwBjhqWJ4nK/O5Mga4F5JuZICACcDmpvStFw1HO/hhvEII4yZp2fwQoza6DTzRetI4i
         LU1uY5Pu5xJjdDcElXSFs55xW9TwKG5aoLo4ifcop1QPmTbhY6ECVjzIzY7ErxvrSlHI
         lq3A==
X-Forwarded-Encrypted: i=1; AL+hErHWoPiCDzzeCLaDEZauWqSv+bjtqqvJZqMOtdDw2AWZk/qFhts270NqOsi8reaRZf3IhZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ToABVyrcAqstyGtIQaDsHElqrcIADFpPZbXTwo7TZxmWREnz3
	/Hbls0TNGcsYFXPMx/+rE7YhSaoBQJpip7VFzM3MXmE0ZpwtjKL3bb5+
X-Gm-Gg: AZFdTZcDbib44TYV4lhVBoAcHwz0ZwDJTw5t5j+0lmRybKC/aaJcjCX5XWRbUslh4m1
	h7a6Isy+KQH6Gvpg+aqJEBwQZghb4RdMEhSjBsV/VTqpgjo6ER7oyz3YdwGh8L1e0B5zYOZYjq5
	e/d/0mFzPQaqTadbSEO915P1/38Yycc8GrwIUN7t4HML1eWP+gHJPDdC2QSmQBBy4k6gPxb7lu1
	Tnx+fqLXHwVkrs2y4Uc5RUJylNrKeWMOtpwthFDb2jslxpFBbxyM7tXl7NlxWC+GzW5QVNdviDx
	GclVZVhPE1vODFoqpqcFPKpiWJW6ljf0UsEId2JmUKDTEl1NI09BrIqgObZUkeKMfxypabyGIn8
	LxsstYFPAhlkrpZ6nzjDDWqCPvCl8zYYLlKvI+KcbB2C6cfRbBWu7BzWqqNIkCpkfgXJu/50N6y
	HaCMNQJZwXv+euD55IaHLOXJmuChbRuIFJdfVO+s5341TTnHFJIReCFM510+pdbMzT2aMSYvrKc
	4ety2J4vCv/d4lTRY4d58xx2/PrF6biTxN8RFOz3rJzPnizOm+nl+f+JU1AB8nJ19D8axRbHUEB
	u6lGhA3kbekr557K2nVtmgLbjvDpth9i58d+Cao5Ywiyh9Rqi5iqDLUGaM61e9Y2Kttazw7N9AY
	umtKl39vYdbC63/bcKGD8Z6RpBPm7HNTif+Zn/SyutBZlRlPUrJIyAqo=
X-Received: by 2002:a17:90b:4f8f:b0:3b4:f260:72de with SMTP id 98e67ed59e1d1-3b4f2607685mr359340a91.64.1795554146817;
        Tue, 24 Nov 2026 13:02:26 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm27414620a91.10.2026.11.24.13.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 13:02:26 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 21:02:25 +0000
Message-Id: <DN3QTN97ANJV.14Z27ER78AES8@gmail.com>
Cc: "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski"
 <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Stanislav Fomichev" <sdf.kernel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: add bpf_sk_assign support on
 netkit egress
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Nikolay Aleksandrov" <razor@blackwall.org>, <bpf@vger.kernel.org>
In-Reply-To: <20261124151244.1423343-1-razor@blackwall.org>
References: <20261124151244.1423343-1-razor@blackwall.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 07:12 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
> This series builds on Daniel's work [2] to steer netkit traffic to a
> transparent proxy in the receiving namespace. The receive backlog can
> outlive the transmit path's RCU read-side section, so the skb takes its
> own socket reference even for SOCK_RCU_FREE listeners.

can we do the assign at tcx ingress of the receiving netkit device ?
That works today. After NETKIT_PASS the skb goes through
sch_handle_ingress() of that device. It runs after the backlog, so
the listener stays borrowed under RCU.
tc_netkit_pkt_type already runs such a pair: tc1 in netkit, tc7 at
tcx ingress of the peer.
netkit scrubs skb->mark before the prog runs. So the netkit prog can
pass its verdict to the tcx prog in the mark.

assign_proxy_sock() from patch 4 needs no change for that, I think:

  SEC("tcx/ingress")
  int assign_proxy(struct __sk_buff *skb)
  {
          int ret = assign_proxy_sock(skb);

          return ret && ret != SKIP_PACKET ? TCX_DROP : TCX_PASS;
  }

  bpf_program__attach_tcx(skel->progs.assign_proxy,
                          if_nametoindex(HOST_DEV), NULL);

The two ways:

                      netkit prog             tcx ingress prog
                      (this series)           on nk_host (today)
  ------------------  ----------------------  -----------------------
  kernel changes      patches 1 and 3         none
  listener, UDP sk    refcount inc and put    no refcount
                      per skb
  other netkit skbs   netkit_run() sets and   one more prog, only
                      clears sk_assign_skb    after NETKIT_PASS
  who sees the skb    backlog, generic XDP,   same as today
  with assigned sk    tcx ingress, the rest
                      as today

With a UDP proxy every datagram does an atomic inc and dec on one
socket, from all cpus.
commit 7ae215d23c12 ("bpf: Don't refcount LISTEN sockets in sk_assign()")
removed that for tc ingress.

Then there is no need for sock_pfree_ref, sk_assign_skb,
BPF_RI_F_NETKIT_SK_ASSIGN and the second set of rules in the helper doc.

pw-bot: cr
