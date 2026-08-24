Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BC35677C;
	Mon, 24 Aug 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583597; cv=none; b=rHY/dMvand/Pku0AJXbVH3JjzRvzi4JoHrB186jWhUQap2lahe6aAR9Hqt1w1f2T3mu14WCeOjNcm4Nsbg3APQNz1/CPLNx8wYSobbLFZioXflF+n5V08QLYYU3/t0Ul1sVtigPvCqm6RlqLdNmTXKGG9DOWuuy4A2bWQ1XMfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583597; c=relaxed/simple;
	bh=1lz9GNT5vd4nkuei9XVegK2uGmskkULx9nOCu1MNVFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu0TTvZzqUeukhvz83MTn1kcymHentrcKkIi3bQu+sG3V4+9DUqP0a4rC6m4PvPn2AiHfI63yX+88IZ3zqEhSFUH2Bxo4jFuqi9omtjsC6zxlKpNJhe/n+mS6y6obo3WoZm6ahpBgQM5fzWSdXh/4xhztWk4SuPh0LphaT00NJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=MGT9z1Sx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R9Wb13ZM; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="MGT9z1Sx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R9Wb13ZM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id D48A813802BF;
	Mon, 24 Aug 2026 10:59:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 24 Aug 2026 10:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787583594; x=
	1787590794; bh=Yu9P/sTLYPHFQVWmVS7Y7Dli1B95EhFAwCCsGt/ZaaY=; b=M
	GT9z1SxWlB/4TFVji7vo9tPCdCuK/gc08BF5AJxPHyA0iw3i4X8SAyhafQtyCres
	/0FSTuz4YJztAs7t3lMFV63ci5h1vi894Ok+AnqmyNN3CAcqc24mI40sjyMvj8wj
	PQ59o6+tcmOZpzI4ag/J6OSRh9e4OGYW4NuGygJGuDyiDsj50tij2YzG4ms1o0Uo
	h12/46SPWxmGD04cGuQ7uS5Oh+E2/2pIpwAxrYaJxMCTnWJU3Vr9eL2rIudgMb/8
	FY8cIeP0GzLiV9Kcyt38VI2aV3C+fHtu4bJtDGSUy8dx2Z+RVCerpAI8hbF75MJe
	XLqd0p0IpJNZHpZLNCX+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787583594; x=1787590794; bh=Yu9P/sTLYPHFQVWmVS7Y7Dli1B95EhFAwCC
	sGt/ZaaY=; b=R9Wb13ZM4u6qNWWJQuTlLX5XFswHrSROHybTuFX0w516wPdrm9k
	fk+yFdV4uIDJvhcEbx8ZRhyYKL2nNOs0Fe5uSALsGbTiyTIBeRrEi52Qq+8m9Zzc
	/PeeTv1+iB5CjFiVewMc1Pe6yUUiool+QzBwQUjjHKuJSnyJiv1f5kmy6wdW47VC
	zozvkPyShdJSU+2sNEx1C0Swi0zIi/un93n5nYllykJx9o0HPWQ//OnGnNlcA+sW
	OjoJ/8H0bDgBJZ/oyZhOew8XvKvCTWatFRt/opbObrZpEfYVzaOEbbuw1PRAywnL
	abDRU4V1vccxp2FGi9JTFxeqP5BkoLYUWWA==
X-ME-Sender: <xms:aFyMaphnihHBiQZNoi7T389o1QTZbtMl2akARdWzQgCaTdYfeuHClg>
    <xme:aFyMaucjM0A6qKXe9E1-iGljJbInsvNsCBKamTairpB0ZbNvF6tJZiuaJuW8qPO4R
    ft-k4xnpN5t_GgO73GjusZD61IFzsd5qfrUaaDMoYDX89e1iVqDw5s>
X-ME-Received: <xmr:aFyMaqhpXl8qyNdtn0eD-FoUVVr94to_TDzYTJ_Cu9NRaZ-8pwuDRL9ksWI>
X-ME-Proxy-Cause: dmFkZTFa7qxHA3qw09qMM0lVFcj/nmVHnRJ0m27uYJT6lMLZ7v1xzgdvd5p6U/QBOQTfkA
    10cJ+0Icwv6tyE9AIciaBSopNETAHkeNH8otyAPTL4UeuxqJpy7nz4i/xGDZlwvRkCXIPm
    0yTGMiT7QIObxGSYPnJ6lbBAlLaGqN99Pisa653oUGH0S0u5rxDTMVZxGCG32mXAP1dKXk
    dMrYaODJGgDXYh6sU8EikjdwkjxNj8YCQ9etN4LJa3av2TnlVTnUKWyZi+Ea3e9YQHJ0QY
    WAWSZFOmBspb4p46AXwaKJRFFRr88VqQ3E4YELG4yvXtevIuuehkYkhSrktLQi4OAr05d2
    CHqx2eywsgxYn5epfHNDF2ZfCYYYWomwJJpHejDRWVNcVRcHovhq5pTLxwf5TZaa++R2D6
    qgTgAfWsFG9kCXRuSBMkvSVNMWAxjfBwOCszJR/Ois+Efkj0B48suowg93eYyLUS1CU57L
    edmv2OcFEKBnswdwkWsxnFum7HJf3g9okI8NBSRWK1c5lDUSXLvwtXo6X9WECibp1L5GeL
    +qSn8UTsBkFDkqw8C64eNO1JAd8g1V7AZsHs/NsQGkBK2CaK4HWl4iP4OBoaV86LVAxfbI
    mTLS9lLSGc42Mn+Ab7nqJOLJzm2Rf+KxZJofVpVDwVvdbTmr8jcThpB1ThjQ
X-ME-Proxy: <xmx:aFyMauQTq7FNe43FkdTdZ1xmY4EuDBBtJivVng_yDA7oqEk3QPMw8w>
    <xmx:aFyMamK8dXH13ZK0xjswRGu0Oh8JfE1Z-eMXPZCxsmDn22bUoWoaeg>
    <xmx:aFyMatR8RIV83iQosn6prU5RDRdiQT_1oz7UUhMw8_uD57JEiR6PTA>
    <xmx:aFyMaruwPSyawHNRKwHvMdXAbu8ET1Zk0BVLqXekf_CWi1J75UJq8A>
    <xmx:alyMap5dO2oBDGIh4DBhvvknyQVXRI2wad-Y0wwN7EJ63nGbX_5UgCZQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 10:59:51 -0400 (EDT)
Date: Mon, 24 Aug 2026 15:59:50 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, nico.pache@linux.dev, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, 
	liam@infradead.org, mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, 
	shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, 
	ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aoxcN7jrfbK_Ac8V@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
 <aoQ77EcD3M2kjeya@lucifer>
 <0153303d-f9d6-45ea-a276-fbf2e5625ef9@kernel.org>
 <aoXn1B7cPnPq7uxd@thinkstation>
 <aoxRs0mjyQnpO-IT@gremlin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxRs0mjyQnpO-IT@gremlin>

On Mon, Aug 24, 2026 at 03:22:02PM +0100, Lorenzo Stoakes (ARM) wrote:
> This whole reply seems AI-generated...

It is not.

I heard David's feedback. Will adjust accordingly.

> 
> You replying only to David twice in this sub-thread which isn't exactly giving
> me warm fuzzy feelings about the working-around-me concerns I raised here.
> 
> So simple feedback - send a relatively small, no-functional-change series that
> improves THP code and lays foundations for future changes. After the merge
> window.
> 
> Can you explicitly ack this please?

Ack.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
