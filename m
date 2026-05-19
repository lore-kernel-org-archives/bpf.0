Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB32628D;
	Tue, 19 May 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208728; cv=none; b=mZg7YO3h0f3Ui4WL2s1fc/rmZBvkGmyY4raUaxX/QOrfpHWxcZ/2vFTX3bFXJkL3NZp6b58E15gixDPbXL5Kd2o2WiIc1DLq6fmIQGE0gTdLezHQNPePpDaBNbxf3X49J1zwFjFxYVpGWE42UO0qb7RHhBiywsGpjnp9792x9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208728; c=relaxed/simple;
	bh=gJVuSIWdiMIFifLL/3/d/ViONNv7Zn8i/Qmq0ftHryw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ0K5O2a6K/CJGpPHHMukHvuzoKeNAltDQL5735MC6yZ4CKHlVHqJH5PKWG8LCq0k6ff+a1hHnUAhafhdy8BpAYSiR5WCr76HDj/EvhICdn/TWBc4BzfszGi6Ut2E7i6LHAIxuGK3/38nKDBI/VAQE0ESkmkj1JrmKHDdmVqCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 854761C0301;
	Tue, 19 May 2026 16:38:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 4D4CD2F;
	Tue, 19 May 2026 16:38:34 +0000 (UTC)
Date: Tue, 19 May 2026 12:38:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Namhyung Kim
 <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v4] tracing/probes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260519123833.6e8dcfa7@fedora>
In-Reply-To: <20260519122836.0bfded70@fedora>
References: <20260518232312.0c78f055@gandalf.local.home>
	<20260519185302.5fb527085a64567a388f24f3@kernel.org>
	<20260519083128.5795c6af@gandalf.local.home>
	<20260520002640.d372bd044ceba9364b1f168f@kernel.org>
	<20260519122836.0bfded70@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kkq7s8dbmixi79zxgkk3rtb6w513nib3
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4D4CD2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18O2cEhEnMeYixDnaE+5iDuJHHFyyn1yJo=
X-HE-Tag: 1779208714-944650
X-HE-Meta: U2FsdGVkX1/Ie51ckfNuYHyhIUs/8bmitiF50pdn6+axf4UT1gkQVI8JAdaYfr/dCu+4TMwVMZEwSJxuWNMpt0csl+CJb2VuMKiab+UnpDGFgMtvuik4yT4oXjcn2VMrle2xAf9ruI1awbJLxT9f6A5FGRHUeV3yr7lUXu/UBKp1EGbSsETcpQC2kG59yR4zNZv+R2n43XqqVkFXDZ/xyhiQt+ZtLIJxiw5WctdR0oL4c7LBvOZ4B/6X4qwtRxcz60SVLKwlvNHvqE91kv67LkYB4g2Jqxh/ktxa7opV30FHRFRcjw/Us7l3Z4y+QVJ5B7C1kq1LMBkOxTxf+Hm4IinKspmZVgg2T0jftcFAvCz36Hu0xZdkcwHBg+5fsR/Y

On Tue, 19 May 2026 12:28:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I added a struct_btf (I can change it to typecast_btf) and have a
> helper function that is:

Actually, I'm going to keep it as struct_btf as it is a btf for a
structure. I did change the flag to be TYPECAST though.

-- Steve


> 
> static struct btf *ctx_btf(struct traceprobe_parse_context *ctx)
> {
> 	return ctx->flags & TPARG_FL_STRUCT ?
> 		ctx->struct_btf : ctx->btf;
> }

