Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB6625;
	Wed, 27 May 2026 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847068; cv=none; b=TSjAWrE7/YnrNlfUuRf9e7PX2aBRfvDZkaNmkSCLxV88ZwCZDM8wxfDV9dQI1OdCiDoSSICXut6oNxg8+VUFli9KqQXQHqdg82SeGLyHPtFmCvnOvfEMiXlSAN+XZkBgikt8rgaDAbxaywGTwRZ3eyua7fW3dpOBiq1+VwUh3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847068; c=relaxed/simple;
	bh=I307GjqM4ZYPQxjsWl9PCkDuG6IPWtsFAP0szooUo8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WY2/83H+aQ2TZPmDvAlIMPrEQwA+iLOlPHQAcxkGW7vg2x+KkR6dMrmI/sxkIE145U2H9h7GKFWLObOcM7EViKR7aSSM8iejMlO5PDiwqzpWq3WMnoBDs1b+EmIwvCXZJZmKw9wtZH0e7zcBFAimm8oe79ziwAznsD/YmfTF1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A75711611D1;
	Wed, 27 May 2026 01:57:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 7F1D22002C;
	Wed, 27 May 2026 01:57:43 +0000 (UTC)
Date: Tue, 26 May 2026 21:57:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
Message-ID: <20260526215741.1e5b3e42@fedora>
In-Reply-To: <eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
	<20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com>
	<eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: i6njdn344431qmbypyfp5995swh3f7ou
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7F1D22002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+6ROqw5nRqi0k+E1zyVGZfmJyYYcnL0Gw=
X-HE-Tag: 1779847063-963849
X-HE-Meta: U2FsdGVkX18Qv2j8uxYautLmWa2hRWqCDd3tsSc6jwvOBmeo9IU2BRVaGu2hG1MN9fwg/Nd8ziyWZxkh7RDPTZ6Al2UG9Vj4nCg4Y5fu56Wzkdu3vxJ+jGek1A6Gl0xHDYtBBgfEkH2WWFgdMbMdXIupBzN4R+A2pbPBK4aYLkg+vA47l/3R5LMxRUqNeloAdqc7qsBn0HQb7q/WTO6dlvInuoN3edQegdyB/BskHXkD3h86Eqhswfly7OeOraZSebzdsq9E5yOsbKm6Coi3iq8gGtx7TCrZ0O66mxKLP3ZyOMp2BLdv7XNYYiKtTICq/6PJu4XtXRm3cuMk6TLrsW5aplVdY1fR

On Tue, 26 May 2026 11:07:56 +0100
Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:

> Hi Steven,
>=20
> Gentle ping on this patch from the series.
>=20
> Since this part touches tracing, I=E2=80=99d appreciate your thoughts on =
the
> tracing changes whenever you have a chance.
>=20

Hi,

I've been looking at this and was wondering if there are ways to not
extend the trace_event_class structure. It's added for most trace
events (actually each DECLARE_EVENT_CLASS). Although when things like
BTF is enabled, this is a very small amount of extra memory.

I haven't been ignoring this. I've just been thinking about other
approaches, but haven't come up with anything. Of course, I haven't
been spending that much time on it, as I've been focused on other
things.

-- Steve
