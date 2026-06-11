Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C4408034;
	Thu, 11 Jun 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198305; cv=none; b=WhTQHw9F/3sHRueVQxkTtJ8BYxg1A7hldIz4ypJX3yro1tev2xZiUWXfgPqINeP/lDF66fkBgwsaHped7EXhJVvD7xkNDR5fIQBCG4HdEvvdTcpeFcajEidadiSmTVXaBy7F2YPHrQ42acC8WAbtdeZJ90JrUNQglDtf70xFBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198305; c=relaxed/simple;
	bh=2/4YhDGk8rS1eb9x1UZCiSNZtGtVwrSNHMRRH8/d9gA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAj9brY7a9HNyT/0YGRFR2DQ6QUsv1/Z1DAne4cLkv0JLU2xCpf1uzzFB3FBkumrmN8odvZjjjJVrAtR+0N+rBYTKAYgaHzMpKJJUqWII5FT+0ixmIjPVzm3BRfCXT6GHaCupK/8j3A+QseZMrULrjXT9/N2xeOtTb0i7VV7t74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I793zi1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I793zi1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F384E1F00899;
	Thu, 11 Jun 2026 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198298;
	bh=4ftVrlKfxNBZ5L1qsZ1tyjka8GLPo2zlURIhpvXfdyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I793zi1XTUiKfGJris+A1lqSuFB+TAYeOfOnqQoP590A4ZtsKdFN47EAGe9dqDFOx
	 3XJfyWN5clsNSrgKpGDwhbXXYaosyPtcrKwX7x5SDkHSlrvj0i4r9L5OAo6G069HTt
	 gu1QUveYay+06rM2IXCcp5+wQ+n+R/z4KgPk8EzS5tOjUjQ9TkrOHoa+Zsi2sq7OXO
	 IO1L2c3nA46BNPQgAHkMOkvPAFNmmmWaOC/4mssqd8ERkTom3wZIIWor4ndqQnAMYN
	 Zt6DUhDo+weFEaHt4temC2C5ASR6HudLCJGAPEen7MWbBg0auYtcb78zonoQ+/doro
	 Qffh/ooXQ+V9w==
Date: Thu, 11 Jun 2026 10:18:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 skhan@linuxfoundation.org
Subject: Re: [PATCH net-next 2/3] docs: net: tls-offload: document
 tls_dev_del, tls_dev_resync, and rekey
Message-ID: <20260611101817.18964bd9@kernel.org>
In-Reply-To: <ainR5GAK8LaHJYMP@krikkit>
References: <20260609201224.1191391-1-kuba@kernel.org>
	<20260609201224.1191391-3-kuba@kernel.org>
	<ainR5GAK8LaHJYMP@krikkit>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 23:06:44 +0200 Sabrina Dubroca wrote:
> > +The third TLS device callback is :c:member:`tls_dev_resync`, called by the core
> > +to synchronize the TCP stream with the record boundaries:
> > +
> > +.. code-block:: c
> > +
> > +	int (*tls_dev_resync)(struct net_device *netdev,
> > +			      struct sock *sk, u32 seq, u8 *rcd_sn,
> > +			      enum tls_offload_ctx_dir direction);
> > +
> > +See the `Resync handling`_ section for details.  
> 
> Hmm, this callback is not mentioned at all in the "Resync handling"
> section. I think it'd be good to add at least a quick note there about
> how/when it's invoked, and what the arguments mean (at least the two
> types of sequence numbers, since the rest is identical to the other
> driver CBs).

Something like this, you mean?

--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -278,9 +278,9 @@ sequence number (as it will be updated from a different context).
   bool tls_offload_tx_resync_pending(struct sock *sk)
 
 Next time ``ktls`` pushes a record it will first send its TCP sequence number
-and TLS record number to the driver. Stack will also make sure that
-the new record will start on a segment boundary (like it does when
-the connection is initially added).
+and TLS record number to the driver via the ``tls_dev_resync`` callback.
+Stack will also make sure that the new record will start on a segment boundary
+(like it does when the connection is initially added).
 
 RX
 --
@@ -372,9 +372,10 @@ all TLS record headers that have been logged since the resync request
 started.
 
 The kernel confirms the guessed location was correct and tells the device
-the record sequence number. Meanwhile, the device had been parsing
-and counting all records since the just-confirmed one, it adds the number
-of records it had seen to the record number provided by the kernel.
+the record sequence number via the ``tls_dev_resync`` callback. Meanwhile,
+the device had been parsing and counting all records since the just-confirmed
+one, it adds the number of records it had seen to the record number provided
+by the kernel.
 At this point the device is in sync and can resume decryption at next
 segment boundary.
 
@@ -398,7 +399,8 @@ schedules resynchronization after it has received two completely encrypted
 records.
 
 The stack waits for the socket to drain and informs the device about
-the next expected record number and its TCP sequence number. If the
+the next expected record number and its TCP sequence number via the
+``tls_dev_resync`` callback. If the
 records continue to be received fully encrypted stack retries the
 synchronization with an exponential back off (first after 2 encrypted
 records, then after 4 records, after 8, after 16... up until every
