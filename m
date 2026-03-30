Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1311377014
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886967; cv=none; b=S9Nn+wyG+/1YkYapFdtGFOqJZ6XCs3APmS5+7O7KocxPGlCAaSbP6zOEE1BR70Ik9mS452vACZqooQPDqFiSJCYTvrKvg9a5HpC1Zaq0bZdbC1DjGYiizFGfDxNvPmL2jiBkeCmPVviVHO2Fb7WTBzmV1JsWWjLAhTbdYzCcnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886967; c=relaxed/simple;
	bh=8sbDidvsoH7WeSYqlDbUC2RV4hRu5d5/32cV0dZ7l8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxzG82i7V2urfVCRdYhwuaArmmogripPHnt2LPHyCKZrngHoQeIxVodMrarVj9MN7CiJzzI5Xrrj/ej7Rv0yM9mglV2sY91K4AL5VyO4PpkqPNzF9xYtZ/o7IU0nntSr5a5Z4OQFzYXEDTi7XU9Qt8vcldL6FyRQTVfuTTvRv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4A92A1A0852;
	Mon, 30 Mar 2026 16:09:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 05B222002B;
	Mon, 30 Mar 2026 16:09:21 +0000 (UTC)
Date: Mon, 30 Mar 2026 12:10:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, kkd@meta.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint
 bpf_link
Message-ID: <20260330121017.32fdebb1@gandalf.local.home>
In-Reply-To: <CAP01T778hqWy5GKZNzd=fqY3to0Qt+CdfMA664qR5aXUMuVbfw@mail.gmail.com>
References: <20260330032124.3141001-1-memxor@gmail.com>
	<20260330032124.3141001-2-memxor@gmail.com>
	<20260330110711.178e66c5@gandalf.local.home>
	<CAP01T778hqWy5GKZNzd=fqY3to0Qt+CdfMA664qR5aXUMuVbfw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 76xotatwzj81e9dyo61n7ncmjq49p5or
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 05B222002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+u31c9iEBGtdTRJhCb/zXKXp7oBzgPD7o=
X-HE-Tag: 1774886961-327974
X-HE-Meta: U2FsdGVkX1+b4Ju5L+3c/K8hOGRAMvyDWu7dewXC1eQ/6eKXZMgNey1EgONDjPVnShMZ7cJpFDv5ygap3sDtAllwQNrXi4mVsc19tzKjJF5g5uMYVyZRh2WwjEt9+jrj04z2kKkxYUSaJElEueDbcYIYi31bioiBATqaHJrsDGX2/Afae7vHNdhK/elNmRND7BPA7AJoHYRYU6cNLK1glqZaUbJZxyAnCBj1ZGIhiahIln0SM3k215d5TQHqOGYqCxImA50y17DTRwONILjuD990lezbCJBH1eR95FwbGx45zVG4Hhlxy7ezPa06hJOpQwl1riMpY2fgnWEEMy9fTkHZuhQxrTtU

On Mon, 30 Mar 2026 17:27:18 +0200
Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:

> This is reasonable, though a slight hiccup is that we don't want both
> RCU tasks trace and SRCU grace period waits here, which a generic
> unregister API would try to do like tracepoint_synchronize_unregister().
> 
> I don't think we can generically chain grace periods on our own at
> all. So can we make a non_faultable variant for it, for clarity? The
> existing name would be too long though; how about
> call_tracepoint_unregister_non_faultable()?

That sounds fine to me.

-- Steve
