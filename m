Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5F383325
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554791; cv=none; b=uJxzTmqlupHKS/L+Ifx0Zo07EhkYzTE12tUdFJOrcUg9X1T2vkrTRQYaw0pCdNLOVUXWri1mmClwcHqjDwKguJ7jVIlCxithgg/1S8TZgciqR4KZYVR295aRoinSg8f/sxhyrWz/HPBKAmP+PC7ye5EmvmKFInFiff8z8Dgl+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554791; c=relaxed/simple;
	bh=JhpW2oLnsp+cHZSVAOb2zeeYn5TQyM7DdQhGOiyM1po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITAd0LWK16YzmA/+z+xDUsWTL4JEtiMtM/rfTi/wCJpTT6a6mRQ695JJ8OYNMvwISWXhWfIBfUR24QcEr5vb8XaUDJKdwJ2CZoz/WvJ29r8PSr1P+2af+WwtHgfo3ZOCo613qy2MWYmWpc+t4jYy4uTyRH9JSLx8Bi0PlamzBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qn48XRVi; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qn48XRVi"
Message-ID: <47b7dc3c-7092-49fe-b849-6847b73df86d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778554787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGNV/YJpEn+sge8vj57aYddAEttZNzqCrydxjg3s/MA=;
	b=Qn48XRViZV3QR/2bV55pzmxbfYlU4fpwsUevkFv0aG/p1C4tc0ZbOMPUgvwLxI5Q/kbFBE
	/cOK2D4Op6Iid4DewpSVIW/kNzjJ0o+ShH7U4Yum+fMdZJgsEeErHGWU3uQ4i6TnTXzWLo
	ZeENjlI4qWB/lO1k/6dr2C7vLorlkGA=
Date: Tue, 12 May 2026 10:59:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 0/2] net/tls: fix UAF when TLS_RX is set on sockmap
 socket
To: Jakub Kicinski <kuba@kernel.org>, xw x <v3rdant.xiang@gmail.com>
Cc: jakub@cloudflare.com, sd@queasysnail.net, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 Jiayuan Chen <mrpre@163.com>, Daniel Borkmann <daniel@iogearbox.net>,
 john.fastabend@gmail.com, bpf@vger.kernel.org
References: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
 <20260511161320.358cfaad@kernel.org>
 <CAFFJMPzw8pcwX9g7iv3F=FpHQyovUgZZ28P7XfH3gmiay-JfpA@mail.gmail.com>
 <CAFFJMPwtWZDrD0=hANXk2cdZGt2ArQEWROGRswKPyiZ+FrG1XQ@mail.gmail.com>
 <20260511190644.23334e6d@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260511190644.23334e6d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/12/26 10:06 AM, Jakub Kicinski wrote:
> On Tue, 12 May 2026 08:10:03 +0800 xw x wrote:
>> On Tue, May 12, 2026 at 7:13 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>> Just to check - how much of this code or the patch do you understand?
>> I think I understand the root cause. Based on Jiayuan Chen’s
>> feedback—that we should deny TLS_RX attachments for sockets already in
>> a sockmap—I've prepared my patch to do exactly that. Do you see any
>> issues with this approach?
> I mean.. I have no proof that real users of the TLS + sockmap exist
> but I thought that they did.


Sorry, my earlier advice was wrong on this point. TLS_RX + sockmap is
intentional.

And there are public discussions about combination of KTLS with SOCKMAP, 
e.g.
https://lpc.events/event/2/contributions/105/attachments/103/126/ktls_bpf.pdf


>> On Mon, May 11, 2026 at 10:13 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>> I think sockmap + TLS_RX has no useful semantics(fix me if i'm wrong).
>>> sk_skb sees ciphertext and the TLS keys are pinned to this socket, so
>>> redirect is meaningless. And both sides racing on sk_receive_queue is
>>> what produces the UAF.
>>>
>>> The fix should be to reject TLS_RX when the socket is already in a sockmap.
>>>
>>> Note TLS_TX + sockmap remains useful and unaffected.
>> Additionally, my changes seem to trigger a failure in the
>> test_sockmap_ktls_tx_no_buf test. Specifically, it attempts to set
>> TLS_RX on a socket that is already in a sockmap within
>> init_ktls_pairs. Since I didn't author this test, I’m not sure if the
>> TLS_RX requirement there is essential for what’s being tested. I could
>> use some guidance on whether the test should be updated or if my
>> approach needs adjustment.
> Your report is narrowly for the verdict-only case in sockmap.
> But you're banning all TLS + sockmap.
>
> I think we need a similar workaround in sk_psock_verdict_data_ready()
> as what e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
> added for the full sockmap path. Or selectively ban the verdict only


Agreed, sk_psock_verdict_data_ready should process tls like sk_psock_strp_data_ready.

> format. But that feels a little less clean. Dunno.
>
> Please, do not repost this until 24h have passed. Maybe Jiayuan Chen
> or sockmap folks (who you apparently didn't CC?) have some comments.
