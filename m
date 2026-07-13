Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AB427F4F5;
	Mon, 13 Jul 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961249; cv=none; b=E3shHbolajrXkDhaGY52k66j8W7L4nqYf8trV+LYAAQfST4IFXq1I8R3ce+sh71udvr3ZSUakQn/YoaR1b8WGnO0dtbzdV60cJE44JMhuDxVnq85zlRepsDJD3YJI/X7CZbhM/r0hRbk00IrtnRgytF4JRHee68GRDYLWxLnx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961249; c=relaxed/simple;
	bh=C7m0ay4Wok2aZExypT2fKxodJ0Su4287V+SfZq2ie30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlNVID74L54hQce0JaDA8UbZQXC2c3UYczUEYLs0LvvODQTUhwucy8gyQz7IcqWtUfgB5HcjIuKKt/AaHUMmNeDdUF17EVXA5P+3dRK11BWyImJy5+WFTmRvpJ7yjRg8nTUuNefcIuKYhbTJWdRKJ/eqX1TH2KRgjKDDpXrUjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tFthWxMY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tFthWxMY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B34B1576;
	Mon, 13 Jul 2026 09:47:22 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1EF33F7B4;
	Mon, 13 Jul 2026 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783961246; bh=C7m0ay4Wok2aZExypT2fKxodJ0Su4287V+SfZq2ie30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFthWxMYZoBdRiXm+DKTNJJJ8ueHX6N1C6OLGagBXpDRcCQbEVRkb2LQNyiK/JdZK
	 8SQHnGOQUIUqf1s8HGA1iiDWjhzEI6ya8owNxNlvwxRbJ2GyEyjFSan1P9yJoO1ORN
	 2noH3F3ijOd274JXEQkP1H9P6R+JhL5xvnihHKvc=
Date: Mon, 13 Jul 2026 17:47:18 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Clayton Craft <clayton@craftyguy.net>,
	Xu Kuohai <xukuohai@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	bpf@vger.kernel.org, Florent Revest <revest@chromium.org>,
	Xu Kuohai <xukuohai@huawei.com>, Ben Cressey <ben@cressey.dev>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without CALL_OPS
Message-ID: <alUWljnhfgLB_4a-@J2N7QTR9R3.cambridge.arm.com>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
 <alD7Rr659mGVznQp@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alD7Rr659mGVznQp@linux.dev>

On Fri, Jul 10, 2026 at 02:07:01PM +0000, Jose Fernandez (Anthropic) wrote:
> Hi all,
> 
> Just a gentle ping on this series. It has Reviewed-by from Puranjay
> Mohan, Acked-by from Xu Kuohai on both patches, and Tested-by from
> Clayton Craft and Nathan Chancellor, with no outstanding comments since
> Jun 11.
> 
> Could you please consider picking this up for the next cycle?

Sorry, this is on my queue to look at, but I have been busy elsewhere
over the last few weeks.

I'll get to it shortly.

Mark.
