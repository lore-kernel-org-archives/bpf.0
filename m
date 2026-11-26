Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655070;
	b=dXgKFsE4glo3lwYIgEa0De7AzC+xkzCybZTRw5I4SDKDpclHmCuMb4efzQPY8Bdj8N1v
	 mChxG/vMwHzSQHnEUTLg4cL/w3Q2MCQS6pP5tFEtrcPPGiQ5Yeb8cpNjJQZCVDYP5uFHi
	 UAS8nx5ogaRNHC6l5IDeF/5zuMXOuuggObKDB5p10M0MVXSaWmGD+3YZfP75qmzDu1zpu
	 E3FXD5NsvshBwU51bNVSQGHF0wNfqp+CnrE0etw9Xg/+FKK/JQyiN9F1C1BeIxGtYUjoP
	 9b2ELLICnKAWSb+ixgsNfuWb1I2zXwI5rMhGOiaWLQOITXhK/c+Cs2hmhb8fsNZGs4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KIktabnjHCDieeGWMO0z9Hmbrz6ngvKHiYWHyOgAZAA=;
	b=NbRHS0djpw0NFGyyCNQ6TMY3U1b+XhK9MZkQyKfQtkdmU7mg2PmHgySWXzMyaPibdP4N
	 C5oFQ9lV4RDor+dQYRFGODDn+JneZnnRc9jE9kwRG0aOEjP4dDAF8zD6rzN9CDwqyogO6
	 6B6EH4kKas9dKZi+4b8Gnssf0ugBmGOEP1/4Tsk6CbbKv82t+NH0hj1U+VK24UJEb8LZZ
	 cVNXd2OxOccwvq1ybHWnR7dcV0dyTPZW5nRQs9ZgObDahMJauWglzRTlg3ZzMjesrB7Ia
	 tWnrQ6nlOV8iAb/1cOaX7ZovQT5+eYrTU/CkBYKsIgs2g96tG0rOMQbkfgvGrZABsGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+32su64;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D8606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+32su64
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso2973039a91.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655069; x=1796259869; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KIktabnjHCDieeGWMO0z9Hmbrz6ngvKHiYWHyOgAZAA=;
        b=D+32su64yEFSWiFy82d+DObqCez07ncCZym22RZ0XHEzbtrSdvgbcUX6G1iliu8nbw
         9NEEBCAi8VkNV/bf8UUrOjFf7RWNb4XYVF7ruEihFZkAzGVF5wY3QD+F+56dyChU0lb7
         aB7VPJVuqGe3sLH769vvgEfgmtX6k0hpB1rvJjk0Rl83rLpa759tLyNSnLZWzVR4czmc
         HFRdp9BjEt6+Q89k8KH2sh78Ha7leOtjVVC6XAZpHzi+gFcu4dcS/MQN7EzK+4nLRCae
         xh+GxmNy+EM1UvoWgVm/191Zfjr+KZVoYjz6iSiaSmsN3i3dcNxqFYCNevP6gXYKuptn
         n/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655069; x=1796259869;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIktabnjHCDieeGWMO0z9Hmbrz6ngvKHiYWHyOgAZAA=;
        b=EqOvu2pO+47wGiZiVmPprd1h+mDKeOlLYyQxGj1mCLRcPRidWGy4KVp0q7zkq1xFlj
         YjBDOqOwPZ6tQOGyCAWZcfRgNKeXCHlocOx5c/S73LJwf+WoxQlyPG4iNeCpu9JGD8oa
         lZAZaRwI4BayeMepQT6KIbpc2a/uZMPkLqhHELXiip4+P2DsEpsMpdXAWR94u08F5QUO
         nCK7Ll3Bh2auIoaJ3hV5jZAWL/yfVZRgwuNW9NTRzS+qIlRmhMatRDSg2BNBzMZq7uZn
         wn0rzM9Y+C3JJ3N4PkPWDfSsCaU3aSKSBIAWjnKc7gemBza1Zo0+w5DwgC/P6xCXvIQN
         kZ+A==
X-Forwarded-Encrypted: i=1; AL+hErG0ybZyYV7Tcz6LeS+5t3cTrDvOfQsp345uTuQeOPNbBMQ2xzE2gVzOma76XvP7yMNyaKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/kykrWlbbHF9STqXxxQCZ5DYiBQH0mtKc3w7OBscXnc1bBpqT
	GFZLwowf3UIEjUpUh8huZJu+X6bIBzqJnqXp1YgSY7YpH5+Lw918/PCa
X-Gm-Gg: AZFdTZcPtpCuQQfICIVoTvRJSA98EAj+vHgbw5vlctbjFhan8EFtbwvyXPzSTih1hZ1
	9tT6uX4FXich61ZgAAR0uvWlnpWNPOMGAEteYl5qx7lOal9U0X2ih7C2X556ZRrYgEHLc2yEc5M
	UKWMz8mWAq+ZBTvBeU8slzTGQu+3sFpkmz0ew2IUSEQueKN+DTEwZ9IVkIb+I84VWBqsEB/GUQT
	mlwguonXoLG+GKdKp+IDHmRJLxlAmpE5lc9EFYe91J8wup/0TQz/cdad24r36KmVgDDP3wmbUFl
	cWSr4se3Ekp7gAkBSrYbUiH92ONd/N9m1kcJ1xmv+vl3OLhlXnaOQrg+5Bpa/l794LNaTq3GrLT
	s0iCv5EuiBoBB4ebMvVf+iX+EcCJrCaV3eN72v9jQstiMPpz1pVB85zRUVBj8jbmziRovm3LLD/
	xNRaSeuIxRdv1qVGGYu/ENwYrSXgCbzwXlcbWBkhuzxUaQsl/uWH8oomp8bBSmqIHTNE88Vac/Q
	ZIW9gzRJORiNgb5H6//FTtVbKN9OK4WeesqaEnaXrxCpocMZWOpVrUgwUgOZdgd1BjP3y5ZhANa
	1U0H9ogajG3CyUWFdlbojZfFrQOaAAkiLgHPFTDaARiBEVfLj4lK5sxaLXPWXoazKQPLvN1hhjp
	4KvXlh9qIgazSJeQtMRNUEB7D028VCmSncg==
X-Received: by 2002:a17:90b:268f:b0:3b3:a421:7e00 with SMTP id 98e67ed59e1d1-3b41c8d4831mr17552841a91.16.1795655068912;
        Wed, 25 Nov 2026 17:04:28 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm30289984a91.13.2026.11.25.17.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:04:28 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 01:04:27 +0000
Message-Id: <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman Long"
 <longman@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Peter Zijlstra" <peterz@infradead.org>, "Harry Yoo" <harry@kernel.org>
In-Reply-To: <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
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

On Wed, Nov 25, 2026 at 06:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> This is absolute atrocious shite. You cannot attempt a spin_trylock from
> NMI context. That thing might be a mutex.

cannot spin_trylock from NMI _on PREEMPT_RT_ ... correct.
And the patch guard against that.

On RT the nolock path doesn't reach zone->lock in NMI or hardirq:

  __alloc_frozen_pages_noprof()     alloc_flags has ALLOC_NOLOCK
    alloc_nolock_allowed()
      can_spin_trylock()
        if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
                return false;

fwiw kmalloc_nolock() has the same check.

> This should not work; if it does, that is an accident we need to fix.

It's not an accident.
In NMI only !RT SMP kernels reach the trylock.

