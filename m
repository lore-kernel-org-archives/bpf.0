Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1C337BAB
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883183; cv=none; b=hjP57TxwOrUDyndmuC3x4cEO0YbeU6XgK8vX/eXmyTcs0AUubo1iDEVHRIXBOE8YGKybSQpFgDvPRqGiHmpVwIutID1u+0t5HZ1wivp+Jb7t9x2ac3NGBB0UI5XnFb6bbdmLOcJ56W+ZM1dzCJWIGx7ndO0huJWMysKvddpbHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883183; c=relaxed/simple;
	bh=OjJn1VZ83I4E6WRyJcg+DHbL8FlAmP+M7lgD7Ly56Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7QrAwmdybafsHYMCW60R7z76KjwLtqHzSIUJDazAQBCwbMbu3dDH7QGosD3QnwTXe71AgtZAabfaXqwbL3nN8w3xr0WiyRKKJCKRXXoXqlDj8+rebcBvDJ4/pSt12ctQ/ueMYWzVtezSCE/tA41fogZCd6m5oAVRTdija7gYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 65E2AE0252;
	Mon, 30 Mar 2026 15:06:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 04DD22002A;
	Mon, 30 Mar 2026 15:06:16 +0000 (UTC)
Date: Mon, 30 Mar 2026 11:07:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, kkd@meta.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint
 bpf_link
Message-ID: <20260330110711.178e66c5@gandalf.local.home>
In-Reply-To: <20260330032124.3141001-2-memxor@gmail.com>
References: <20260330032124.3141001-1-memxor@gmail.com>
	<20260330032124.3141001-2-memxor@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04DD22002A
X-Rspamd-Server: rspamout06
X-Stat-Signature: abz9baajs9gdywx6ryp6fu49e9i4r8a9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19l5SdpFF201ganWNUVQcQJEADMeuIbYuc=
X-HE-Tag: 1774883176-97358
X-HE-Meta: U2FsdGVkX19wcziws53MR55MCVgiYqZNEF9k3PP5TG75jNlB1qoXaTION9S1R+UvdqRF3rkntcWolaDK3jcSHi/6AbTezm5AIhpHOVd0oDjvt7gXeIbKzTlg6JJhvxkyCFpu4qiVh/pbEzFOeoyHa+u7xXDfmk0YD7Q2MJi76GMDs/dgdn7dJ/s2VNgI2pSHRX0fiL6zS2K0rhphIIMMv1tyq+lDOH4SOiU5d4fbhaRt1w/i0gwL8HdmOWi77rZLpdopFMJST9TOW4LS1CzsQhvZLcz5EqNmXmjf+5B3szLUIhIBSMjKi/IJJ/OMumZEit84rm5ExaC5praf2Id3qeMDWPHg4l5J

On Mon, 30 Mar 2026 05:21:22 +0200
Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:

> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -113,6 +113,10 @@ void for_each_tracepoint_in_module(struct module *mod,
>   */
>  #ifdef CONFIG_TRACEPOINTS
>  extern struct srcu_struct tracepoint_srcu;
> +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> +{
> +	return &tracepoint_srcu;
> +}
>  static inline void tracepoint_synchronize_unregister(void)
>  {
>  	synchronize_rcu_tasks_trace();
> @@ -123,6 +127,10 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
>  	return tp->ext && tp->ext->faultable;
>  }
>  #else
> +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> +{
> +	return NULL;
> +}

I rather not export the internal workings of tracepoints like this. We do
have a tracepoint_synchronize_unregister().

Either you can add a workqueue that calls this and then frees the
data. Or possibly we can create some kind of:

void call_tracepoint_synchronize_unregister(struct rcu_head *head, rcu_callback_t func)

helper function.

But let's not make tracepoints being protected by SRCU an exposed API.

-- Steve

