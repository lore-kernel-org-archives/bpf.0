Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CB3C4154;
	Fri, 10 Jul 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698930; cv=none; b=K1PaY7r03mpovAi7OlRKKxE0YHKLooIdAWmpftG8ShJojeazb52LbBUtqvQM7OKss/fLtueDuoArMweG3VlOC/V6zU2hCc/6w4gfLVrXO2ctZgdjZg9Y+RoWGycEyXNNc/xKdanh8iRFWI8uUQQM4UhwmFNVX368HEnXCV1xcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698930; c=relaxed/simple;
	bh=QXzL/asffhKe/0ho8h2qcuZoIXtXaztBg7eKLa96qBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fe5Jy3qpdMHRZXZVKF8szNxQ0k28uJc4G9flLFsvp37YIQTDGnDNCD3qruL9xx7RStg8u4eNbNZaltn5dxA7A4hGA0zM2CrSfKcBxR6kmViTDLPWrM5jNS4iHQi1VLcQHGzKLnEmOBUGJc758yNIDo1JA1B7lmBK2SHL+bKlFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id EB2BE1C3C34;
	Fri, 10 Jul 2026 15:55:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id F41F62000E;
	Fri, 10 Jul 2026 15:55:21 +0000 (UTC)
Date: Fri, 10 Jul 2026 11:55:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Puranjay Mohan
 <puranjay@kernel.org>, Clayton Craft <clayton@craftyguy.net>, Xu Kuohai
 <xukuohai@huaweicloud.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 llvm@lists.linux.dev, bpf@vger.kernel.org, Florent Revest
 <revest@chromium.org>, Xu Kuohai <xukuohai@huawei.com>, Ben Cressey
 <ben@cressey.dev>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without
 CALL_OPS
Message-ID: <20260710115531.626f1e09@gandalf.local.home>
In-Reply-To: <alD7Rr659mGVznQp@linux.dev>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
	<alD7Rr659mGVznQp@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1b516kuk3c4c1rip1isp7pq1m9efroyd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: F41F62000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18VXkSf3RGQ5/OWlm4BQJh8NrDk/AyK9ZA=
X-HE-Tag: 1783698921-218184
X-HE-Meta: U2FsdGVkX1/ARi1Y+mMDcyLyMrsGbKd8T7pdCf3U5E+/bEmvRcWpNpXMmXFAgmgQMwx0coL3oTGo4ESx3LzWsN1pJmM3FEVw1cXW/ZqiiFvJm6lNo4WwQBEjcMMBNGYhriRw/3qCHxJrXwO57UxmANF2ZDarJOslhYoxzt+nKE+Egpr8HTSxXDGHCy6fYPwOT6MLrGRO6VDzD9hgX0Exofx8itHAHSGHRhc9oL/9FOeNb4otrGD6dqzaYuIeMhNuoIMGctXbBVpWkX/CEtLSyx35MgrrZpd3sC/vh8JCgQ7Ar6kabtuYyRvO16SvoSWN

On Fri, 10 Jul 2026 14:07:01 +0000
"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev> wrote:

> Hi all,
> 
> Just a gentle ping on this series. It has Reviewed-by from Puranjay
> Mohan, Acked-by from Xu Kuohai on both patches, and Tested-by from
> Clayton Craft and Nathan Chancellor, with no outstanding comments since
> Jun 11.
> 
> Could you please consider picking this up for the next cycle?
> 

As this is arm64 specific, the decision lies with the arm64 maintainers.

-- Steve
