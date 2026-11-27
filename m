Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762475;
	b=ExIvnlD35fx+cB7QXXHbcv0tIPKM+kSSQkVLjLFwESGPAuIondhcWUZOv2K/TnF/Wt9Q
	 I+fRVdUxbJ9JIPSFV2f9OPdIg/yH+XP4qQDE0y/dstKuUYf1NlWPcg13K8FDWrJjKXYtA
	 U+nGuvjqTn3uYYpTKIlZbq+93W9RHmfPiKspV6nDKYbz5rJD7XCJMXTVWuiD/GkWH738T
	 rIX04KSfSsxobSuYmD4QeHENdpy04AASn64dBgY/LVfo/7jJX9KTcU7zV4L1Uz8V040KE
	 cdE/xAnzbNxG1AvdFcT5ifr4S9CUps+YJSpql3h2ln2JBVfodkLLaQQsi5uC9ao8RgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762475;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ldgBYXNws0SrExrvq7eT+4NnxJR8sVTNBuuXZq814K4=;
	b=zoN1/r83g+03aThfP0cwlIbW906BXWiVXwrzGwJeYjHwe0PhEsH1bPA9NJoFo4aKsNIH
	 sK8TNZ6JFIYyO7FhA2AHC8Q2VqCoka+kA6fn7bk1M0W51D/96PDec920xgIRtJWW6Cdaz
	 kEb7rNpUMZt4s4QofY0WXUT8MIdWMUj2gaDWzDJhu1VBM0SHzT98jO+Jhe54HWq8Hf6A2
	 kQ7Pv1QUGNSqaVqdLYwmfOnj1uxn62lfYJghZZJN0LBwpTxx4kgVyZPU647VLrac+IQba
	 8zxKE2bxj2HPn5Ez11rG+LPMOzHQy6sGhT6o8r6XoH0suJUSOZXNkEpjWjGiE1QgZDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=srHIPuTm;
	arc=none smtp.remote-ip=91.218.175.169
Received: from mta0.migadu.com (out-169.mta0.migadu.com [91.218.175.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74E606A323
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 06:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B74E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=srHIPuTm
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h5rar8UUerAtpvggvfcIKvDaE3+p/9NaedNCkZ6XPI4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795762472; v=1; x=1796367272;
 b=srHIPuTmAbozvAb76f9ZODMlxakRy9BKzVtH6BdUOSiPl6TMVnEIsMPAMHyeJJ11m5UcbiH9
 5eqYr4WJJQGOLP8O7E81eowjttOhEtB13JwE/FLs+CIf0BfoRhmasmaCneJxOmFzfGoXxuJgzbE
 b9Tm9zHcLFX2jfJk5OUbNIDw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 5fb339c859fca4ae;
	Fri, 27 Nov 2026 06:54:32 +0000
X-Mizu-Trace-ID: 5fb339c859fca4ae
X-Migadu-Flow: FLOW_OUT
Date: Fri, 27 Nov 2026 14:54:21 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: undo enslave state when XDP setup fails
Message-ID: <awkpHepMHPoNNYf0@fedora>
References: <20261125-bond_xdp_rollback-v1-1-35dddaa337ba@kylinos.cn>
 <sashiko-outbox-235667@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-235667@kernel.org>

Hi,
On Thu, Nov 26, 2026 at 02:00:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] bonding: unbalanced bond_slave_ns_maddrs_del() calls in
>   bond_enslave()

Ack, I will remove the call in err_close.

> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [Critical] bonding: missing cleanup and 3ad unbind on XDP error in
>   bond_enslave() [1]

This will be addressed in another patch.

Thanks
Hangbin
---
pw-bot: cr
