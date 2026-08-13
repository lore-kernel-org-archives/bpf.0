Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D022AD00
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605836; cv=none; b=X35dtoeWaSn6tBoY023ZZNdlM4leRAHlFzKla6Fn28eyx/pycNTnti4eDU/Svc8Ws1lOGBS8VBumtoJJz5AHLv8tcf8pXt2gRMh/fknl299vjWh2y4rV+/0/o/7B0cr6blLMwkLcpNK222qj0lyqagsyu1s0xx+Q6UkUuV/1LnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605836; c=relaxed/simple;
	bh=aqRz+kPP3qjzjRfTNdDtBwlQF/9uHWyPBbr63dwVqjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM6gjuVIuUbkWMlGluRcPOk/rQ0fU8ZY4xr9TvHD0G6lQRRd2/Dq9f6DAs2SXNtI4/3n7HGTD93sp9Yj0nzvcyNBlIM39PHESSe64IFKw47IjSU4wleyUffJMuB275HHwir/SI06Wugohxy+gtZhU9pTMzqx8pFO5ue90HuMXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=sJ4KIPpq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="sJ4KIPpq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cfff5f88dbso23282355ad.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1786605832; x=1787210632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9lKO3+xyZ4hhyjwwtug2ynRmplAxGz3tAcmomQ/8nk=;
        b=sJ4KIPpqC+IzmVLCrZyb7Y9vCpq/l1BtBMWBmSsTzR+VSl5BTrcI33V03VAdDyomra
         +x7vSF5UBnQzQOOFDZCHJME8jp6kaSfXaWsRqtuotfC5fPOoODy6SyxNKCUaJbeyy5aW
         v1/dxR0YEA4d9U8jsUrts9XIVWn8L9ldO9G2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786605832; x=1787210632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v9lKO3+xyZ4hhyjwwtug2ynRmplAxGz3tAcmomQ/8nk=;
        b=TeIGxJtnS+urAH6fRxho6qmQZieBWR20/kaRe5MJastuGSfRD8yv0LNAcbVElT4Z9Z
         Hr+zB/lrDpJqw8ru3lH02fzL263ZGJOR6ygKgXyGVw4jNq/pZ5IUuXjbS8J7iS7RT/Ww
         c261WqSH10FO/ZYbpotnwHutG9bd68nZJUGWtxRA8M3fDgSztx+6Xphd5Ss/ztyDe1Aa
         SgNKEdtElCba3DRKdAiwui6erYLkOIrerc8OVmnaaPAB10XaE+kAQQ0328C0Fjgy2cVq
         KS/LTLmulSj0Dh3nFl2DWl6Njtri2IPHiw8cKHodZZZCeYwvqF8XyCyFup6oWGKqZiSS
         FhXg==
X-Forwarded-Encrypted: i=1; AHgh+RqYOd6kDDZaixAEusTQyvclfM6fxlXKatktma9RJJzo7OI84L+7+FRLaqIlt/znDJXjM9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKpMySje8/3jJvurXLvvCdWey/mn+69AhtbDy313JmFYi3Zwfz
	VH2Dd1eRyBbDl6uFGOu3GAwW4d85jJc3by4/2T3zRyNZoU3rqu2ILVruR+Cc5fptbLU=
X-Gm-Gg: AR+sD13vSYuhzyoJqgSqcj4z4ZwlBJ1Zm+FyDtYrhJHbF8rFXWyDD31164HELka8YYd
	4PzU77kL8yicMQmh9BdVMY2i38ezqL0mpIv4+jCFlxLbrfyHLCuAXoTvyR0V1gA8+Wx8ppeb2AE
	kxkIHZK5zKzXF6WBjxgD6/Y5Zyb0PLS4BF2V6xTgc1h1Mpt+Qec3dT95eGLxIGXNy3NiQ0ijreP
	WGy1K8cZvdPLSLEDyy4N8aUbkWNcEtJWqtTcRwMo98MXrZnqNno2GgaQre1IMXHM29khPAGuKyK
	l5QssR5SHC5KEY/vNqvceoqsQI26gEsCpWax83u9kshBh/60GnyGYWPgk1I5cYv6+uoVBimdhWc
	icHNftzePUmBh5yABCzu1UA6TLBvCqy1WjJ7GNLHW+PQb01xPEevRHJR/ASQoWEY4JxOaJvh999
	ClXJedIWd69ZlQq4Nb6HmGt7Mz7r/PsjNcI4jb+1r4c1bw22/ytXaFHbdAf97dyCBAQd+EXA==
X-Received: by 2002:a17:902:fc8f:b0:2d1:1a28:10d with SMTP id d9443c01a7336-2d37e9b040dmr49290675ad.18.1786605831858;
        Thu, 13 Aug 2026 00:23:51 -0700 (PDT)
Received: from desktop ([147.46.174.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c4d4354sm5288505ad.81.2026.08.13.00.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:23:51 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: jiayuan.chen@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kennethbwlee@snu.ac.kr,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	rhkrqnwk98@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: BUG: bpf: WARNING in skb_vlan_push from TC BPF action
Date: Thu, 13 Aug 2026 16:23:28 +0900
Message-ID: <20260813072328.984189-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9e2313ac-ea90-4911-9fc3-9581ec44bafd@linux.dev>
References: <9e2313ac-ea90-4911-9fc3-9581ec44bafd@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiayuan,

> Could you check whether the fuzzing log contains any XDP-related operations?

Your analysis was correct. The fuzzing path did include XDP-related operations.
I've managed to create a C reproducer to run on v7.2-rc4-102-g4539944e5151.
The reproducer

- attaches generic XDP to the L3 device sit0
- calls bpf_xdp_adjust_head(-14) and changes the Ethernet destination
- uses bpf_clone_redirect(..., sit0, BPF_F_INGRESS)
- attaches a TC BPF action that calls bpf_skb_vlan_push().

The relevant state transition showed as:

  after redirect to sit0:  skb->mac_len = 0, skb_vlan_tag_present = 1
  after generic XDP:      skb->data - skb_mac_header(skb) = 14.
                          skb->mac_len = 0
  in the TC BPF action:   skb_vlan_push() reports offset 14

And thus the following warning appeared:

  skb_vlan_push got skb with skb->data not at mac header (offset 14)
  WARNING: net/core/skbuff.c:6477 at skb_vlan_push+0x51c/0x7c0

I've included a short log excerpt below.

Thanks,
Kenneth Lee
---
Reproducer output on Linux v7.2-rc4-102-g4539944e5151:

[vlan-c-repro] BPF_PROG_LOAD xdp adjust_head=-14 mutate_eth=1 fd=3 errno=0 (ok)
[vlan-c-repro] BPF_PROG_LOAD clone_redirect ifindex=5 flags=0x1 fd=5 errno=0 (ok)
[vlan-c-repro] attached; sending packets from veth0_tag

skb_vlan_push got skb with skb->data not at mac header (offset 14)
WARNING: net/core/skbuff.c:6477 at skb_vlan_push+0x51c/0x7c0

Call Trace:
  bpf_skb_vlan_push
  tcf_bpf_act
  tcf_action_exec
  cls_bpf_classify
  tcf_classify
  tc_run
  __netif_receive_skb_core

Debug lines from local kernel instrumentation:

__bpf_redirect_no_mac(): after skb_reset_mac_len():
  offset=0, mac_len=0, vlan tag present

__netif_receive_skb_core(): after do_xdp_generic():
  offset=14, mac_len=0, vlan tag present

tc_run(): before tcf_classify():
  offset=14, mac_len=0, vlan tag present

tcf_bpf_act(): before __skb_push(skb, skb->mac_len):
  offset=14, mac_len=0

bpf_skb_vlan_push(): before skb_vlan_push():
  offset=14, mac_len=0
