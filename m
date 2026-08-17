Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C893AAF5B;
	Mon, 17 Aug 2026 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961547; cv=none; b=tLKXPVtNWc3l6ZGvNBci6BoH1XrKlZruzKpx61u/ORSxs6vxkwiVTCHOeqG018qx9DDWWIBwLjJFaUjG6d+Zv0gs+rXuh6vdu7AsmFVG4T3bOLsUHwxL2DLgrWO1KrYNkAT0bgeSzuIrL7cZjuWoR1Lf8H9qE89i+V0EzYyxVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961547; c=relaxed/simple;
	bh=rB6OVwdsXXCAGKXTgfp8Kmoki85JWZCeQYezlggkZ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je7f4Glhu7olVma2Sy0U1/I+LMytNByJaDBcL+YjXa+Fqqfv/tYm3Gn8hSnn/bQqDDdJoZP9yOzV1Oi6wMXspb3CEHmmwACgh7RsvRFwdn5mvw/ELKzAHL1vRUaEUdUy/WOBCrZ4gSms0HJdBmgBjuAoZh6qrk4fK+xFUG/wKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=xRQqngJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfTV6G2L; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="xRQqngJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfTV6G2L"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 63A571300117;
	Mon, 17 Aug 2026 06:12:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 17 Aug 2026 06:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786961543; x=
	1786968743; bh=X2HZwQB8X79/qdi/4/eTag5lQ6IwYEUzzGIop06qT48=; b=x
	RQqngJsQvZrHf0s86jYgcXCj5Nva4QQgYdFLWvnPsm5pHlQWL4f4JsJcJmhZ1KQd
	ebFLHWOBGxdPAmJtctVNUyRxj4+VhIKyNK3YnVAl972sH78EIK6ce05LQA1UmvkU
	Gc0qqJ5KtPCg5gpc6OycPPTdXp5kb76hiwcFxd6wLtAauHCP/cYu4yRlnS/I0yjs
	UiNYqJKPGN+Zk0j7dIYGHCZ6IHNKZAZutsmJpaYFEHXXzjaNobM3+E+I30W4Xu50
	CkT4YMcOK0UsdcX7N/2ylmqshv+nlx8VmsGzHdAQQOacPUw9o/w4fiTgYAL2VncB
	gc/zLvswJrx8vPKiXrWLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786961543; x=1786968743; bh=X2HZwQB8X79/qdi/4/eTag5lQ6IwYEUzzGI
	op06qT48=; b=CfTV6G2LTjN1icCJK3DcPrP9QPJjVSJHPG8zI/AUFBKAc5iZ4xi
	BEA1j8oQreIWLuZjLOeq7e4byBwT98UUCgo1D0bLn82yuUMTZU4MxtGr2rV3/LAq
	ncbRIN7DVdoL71TC5/EEaQ7K3gsezUrzmGlp0zVOEyNLHVPxo8L4R69Flq2iSwuf
	2KPlbdSf8PPgZzMEF6QGo+EBmKJDYufqpS6CR1Z+1v9jmcHQ047HbO45s30og0Mv
	rjxJv16nupiABUJpZxDIh4swNyobXKpmzNbgJO9pxVu9ltBYUgDTjlonPcz7tHJT
	60r+kqnOk6LGF3nAFaaIclnFyXE9txjhnyQ==
X-ME-Sender: <xms:ht6CajzZR34q0SpE3IBGlWMzV0HsL-On7sQsj9W0qut91mX6-gWjjQ>
    <xme:ht6CarveJbz5zfChiOhwbUClj7gzKj2j7UzbG_Z7gTfe2kKYdHvuMQeL-DwdBY-jE
    NiPYswveJGNCTo9suitCqpiy48ahU7evBboWLm-2KKLJFyTz0-k4wQy>
X-ME-Received: <xmr:ht6CauxtAk3icX5Uj3LwCKfQQvgQ33e5GquzNj3jh6MWY81ykc2npIuhqco>
X-ME-Proxy-Cause: dmFkZTE04h/Xk+B6F38wg1Z4C6OmnrAKlBfM7UzM5EIQKp4sCWLVWOi+/U7GmJGoQVV3aU
    PCZ6qKdMqIGgdq11Uk+Bvg3GH0Qksqp9icwfxUi8xTi0VgIM9ofTpDppNiUf47vBs6CnCa
    61NgyKhphhFRp6j0B1wVtMY/dUPe6YISZOK/wa2GNLF6Pdz3RFO7QexzO+CH5Dzon7VkqL
    cUykLN6rKkOh2b64Cj4PEuZ8L0YOl6N3I5fW9T7NeStA2TOnjgJqfJ90ZWJWfkCgUetW8k
    BwRmAcnGQoAwDIW3yl/VOiIdWYaNABY6slB4PBxG9o3FolT+tORmcgvXoOLN6jodX7rQHi
    jtZcozexYhIZ73a4vTqm+HwRcZ+j4fnZ7nH2DgowV2OWuwKGUJjmojdWA5wbuU4UfE4WCr
    XiSNq/MJrOKZsWh0BQ/fdiF/3UIo6WSAigw1v9d34tpR989iNEBeznfkd1GbFPo9SDz+jM
    ukwd2k91H36BTEsP23SmdgqLLptzUc8tZxoDRdMmYEe2tkdWI5GmKU5pWWItjEYqXvpUoR
    eRoIHtCk2h7wkLc/+7cF2eDgtfbj/UX/q/ipDTHmr6VYhkwM0NuLOf6t9SW2CyIZhZZGuv
    JE79Jf/na2ye8Z/yLwVLL8B+/otnZA/k62pQwiGUk3SREVwoN8JCWEH9X3kQ
X-ME-Proxy: <xmx:ht6Catj8BSPlV6w5NE2AfS7My6PfEb6qYAePZKZcqv2EbIDrekWfyA>
    <xmx:ht6CakYkZruLAxRYLQcbZXIs0Lo_GApO_kKv2aijIaD26LH4oRaL6A>
    <xmx:ht6CauiQJ3zXuSu-QM-XGtUkcsIqBNywZufZq5nCdi6ytv4f0seGig>
    <xmx:ht6Caj81ZylIxOsO7YPadr1koFSi6F9Xcjdfa_-XQ1wfWK1AZLi98Q>
    <xmx:h96CapKWXoutgBeqJ8uTcWbxvl8CkWe79PwwUwJ5FsBS-iCjL65xbjOI>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 06:12:21 -0400 (EDT)
Date: Mon, 17 Aug 2026 11:12:20 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, baolin.wang@linux.alibaba.com, baohua@kernel.org, 
	dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, liam@infradead.org, 
	mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, 
	surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com, 
	usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 57/57] MAINTAINERS: add an entry for collapse
Message-ID: <aoLecacFrU6bqmp5@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <20260816224609.308019-58-kirill@shutemov.name>
 <aoLASuFkQ3rUrWa0@lucifer>
 <985a5b95-e2af-4603-b2af-973cd634cb59@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985a5b95-e2af-4603-b2af-973cd634cb59@kernel.org>

On Mon, Aug 17, 2026 at 10:08:32AM +0200, David Hildenbrand (Arm) wrote:
> On 8/17/26 10:04, Lorenzo Stoakes (ARM) wrote:
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 7c179b333e4e..4e4e5030b979 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -16955,6 +16955,20 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >>  F:	include/linux/balloon.h
> >>  F:	mm/balloon.c
> >>
> >> +MEMORY MANAGEMENT - COLLAPSE
> >> +M:	Kiryl Shutsemau <kas@kernel.org>
> >> +L:	linux-mm@kvack.org
> >> +S:	Maintained
> >> +W:	http://www.linux-mm.org
> >> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >> +F:	include/linux/khugepaged.h
> >> +F:	include/trace/events/collapse.h
> >> +F:	mm/collapse.c
> >> +F:	mm/collapse.h
> >> +F:	mm/khugepaged.c
> >> +F:	mm/mm_slot.h
> >> +F:	tools/testing/selftests/mm/khugepaged*.c
> >> +
> > 
> > I'll look through the series properly, but presumably this is a separation of
> > the THP collapse logic, and therefore should have the same maintainers/reviewers
> > as the rest of THP.
> 
> Jup.

Sure.  I just didn't want to volunteer anybody here.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
