Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354836F438;
	Mon, 12 Oct 2026 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812407; cv=none; b=NN4vTh9mUCO2sMBy4SPb+MG7AzCXLNAWImVizx/cmcP3MQEMZw+q0SfHR5Qn6L26/EnglNS48kqtywsC3pYrxP+ruNBtp9p7BJd1OcClWPS+Otg+v52e5mo88DuNZ7mHT0i2vksb17H+kE5IC/LA8iNzfq/rSNx9qNGDgVamPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812407; c=relaxed/simple;
	bh=PFKHjr+/yndK2KHA/e7NuGiTMOh6O9+0i8J9FfT7qKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acJSIBQUqtszQc0nX6WjL2RJ33vbCchscm7PrRs1EEdUebrz/hdg5mLMCrio7+mv6ZcDCAT2CuDHx0O9F7zgwNxZMETyp9JDEk4u6z6kIn5CQ4xvLfxYzhypB2VVtSo5bCzTJ8qCSQ/+Y9Jtc78lrA7BENrUYzdBe2RxxBdX3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=aU5aEpj1; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="aU5aEpj1"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id DCBD8160A9F;
	Mon, 12 Oct 2026 13:40:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id BAD588000F;
	Mon, 12 Oct 2026 13:40:00 +0000 (UTC)
Date: Mon, 12 Oct 2026 09:42:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] tracing: fgraph: fix the quadratic shadow stack walk
Message-ID: <20261012094227.129009c2@gandalf.local.home>
In-Reply-To: <44b54799-6cab-4bcd-bce9-d8d55517a7a2@linux.dev>
References: <20261001102909.1152572-1-vineet.gupta@linux.dev>
	<44b54799-6cab-4bcd-bce9-d8d55517a7a2@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: BAD588000F
X-Stat-Signature: u1udhqz8s93fu6f9phuk9qoep3w3s1ra
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8DfiUq3zZm1L/WURxNHvm5emMN/ky45A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=lElbhry/zhDgg3RQPkKJLuzqYAEGQeSeO5AlUmbdQOk=; b=aU5aEpj1gNrPY9nubSLAsM0KpqRVyRLX+vYPWH8nLM/9HZ+NfUVKCdKwssdA8GRImfRzs6/n54tuIa54DOv4QsoTI7WLhWxXmGYxrpMy3qzKZC+w90EWm5Z6yvTcXzHxUxLyEwaTMbrjqfVbBQkkLM+Y+qViuDq967uq0QWZM14=
X-HE-Tag: 1791812400-992312
X-HE-Meta: U2FsdGVkX191F9VikS2bXGIwimZSHUj/mj7jvrLMslP9KzdKv+uNY6wNjlYqIoqxjIaMpXRNI0/4Ptc1//oeXZ1tCVok/o2dmumNHx9jqqV/b23hsbGAIqpbxtGTTcTKw4ULSG4IUWUG4r/WgFUFtENTyTPWKBr//R7yJfvp3cWATX9tU+gSH1li/VtvbeknGKIBHvPl2TPmoQbEiL2VAUayUzexEd25k08BkXWCavNQL2rNyJ9qdQzDZgNDwFibz0lJIHK/Hd564t79/o4p7UbrHi7Jvc/sX2TZ36hEQktdvcTuq3zkFQ0YPETATF7G

On Sun, 11 Oct 2026 09:58:37 +0530
Vineet Gupta <vineet.gupta@linux.dev> wrote:

> Gentle ping !
> 
> I appreciate folks might still be on the way home and the mayhem of 
> merge window.

Yep. I just got back from traveling and haven't done much upstream work for
the last 3 weeks. I'm way behind.

-- Steve
