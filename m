Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD183446CA
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676140; cv=none; b=STCwwNQXw71Y13BcXAYCIMZpte0oT8PPieuCjqhm6a94fmC+XeaJRV80y7CEvC83oaxblfRIT3vbZIdedOVJQiO6Rh0MNHG3Y3cooYaJb6+pT+RWZBbZApDBxT3NPpT98kCCA3UgTDALB+rNUyyqMvDgQta/RFN9+CV5KOsewL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676140; c=relaxed/simple;
	bh=xeU+CpDbjuqTRy7NHM9S1q/5feA7r1UJohNuP6FPUFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFILL+x3gBD5np5iLk2bGdBRDdng5+6EKqBa2SsU1BnV08o1cCEwz82CfdZdU2DEQOrLrK2SG2xvO0jbY8B3zdot4QO/g3H90jFYYlcqeDVt2nRWrEIdQqGGB8hLd/yBNLp9ffH63KFR/DfkcNabkrDNaV8qu1ZA5SuA36m/0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/N/2nXJ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/N/2nXJ"
Date: Wed, 8 Apr 2026 12:22:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775676135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r06+65cH0yTHLeV6B/4VEG9UgecJFocJ5Fv7CVecJZ8=;
	b=j/N/2nXJ6G/XzxA/pZ7oHUMlkEaXecPiuV/MvK4oy24x+6smZSOqY/2JVzR45w8g6cpV/C
	7WWB3gIXOZd4TOUeNgt724+fOogHzDpb2nVnNOZNEG4/+hblxfXW+bRP51bVkM+DgmhLlh
	u7EH+taxjWUhaz0Ec7A0i5B1NssR0fw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
Message-ID: <202648182730.i4ki.martin.lau@linux.dev>
References: <20260403015851.148209-1-jiayuan.chen@linux.dev>
 <20260403015851.148209-2-jiayuan.chen@linux.dev>
 <20264619471.he8Q.martin.lau@linux.dev>
 <4820d99b-f2c4-4b24-b90f-87e6444284c4@linux.dev>
 <CAAVpQUDz_rUFF1A8XDyE13fLTsgdP5k0XWGtdB1V3r=Z_mJW+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDz_rUFF1A8XDyE13fLTsgdP5k0XWGtdB1V3r=Z_mJW+g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 07, 2026 at 09:25:06PM -0700, Kuniyuki Iwashima wrote:
> > > sashiko has flagged a similar issue with larger scope.
> > > Please take a look. Thanks.
> > >
> > > https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%40linux.dev
> >
> >
> > Thanks a lot Martin, sashiko actually dug into a deeper issue here.
> >
> > Eric and Kuniyuki,
> >
> > I think the AI review has a point. Since BPF can modify skb fields, the
> > following sequence still bypasses the protocol check in
> > bpf_sk_assign_tcp_reqsk():
> >
> >     // for a UDP skb
> >     iph->protocol = TCP
> >     bpf_sk_assign_tcp_reqsk()
> >     iph->protocol = UDP
> >
> > On top of that, bpf_sk_assign() already has the same problem — it doesn't
> > validate L4 protocol at all.
> 
> Sigh... honestly it does not make sense to me to add changes
> in the common fast path to protect someone with bpf capability
> shooting oneself in the foot.
> 
> On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(),
> can't we mark such an skb immutable after the helpers and catch
> subsequent writes to skb->data on the verifier ?

Clearing the skb->sk in a helper like bpf_skb_store_bytes or
rejecting direct writes to skb->data could break existing
bpf program.

I suspect adding a simple iph->protocol/ip6h->nexthdr check to
the helper (e.g. bpf_sk_assign) could also break some
tunneling use cases (e.g. ipip) also.

> 
> 
> >
> > So I think we should add a check matching skb against sk in
> > skb_steal_sock() instead of adding check in bpf helper.

Maybe limit the check to the '*prefetched' case in skb_steal_sock().

FWIW, in the early days of bpf_sk_assign, a tc bpf program could only
get hold of a tcp_sock. Later, bpf_map_lookup_elem(&sock_map) was
allowed in tc, and then udp/unix sock support was also added to sock_map.

There have been discussions on tc bpf programs being able to do
bpf_map_lookup_elem(&sock_map) to get a unix_sock. AFAIK, this
looked-up unix_sock can be used in bpf_sk_assign. It probably
makes sense for bpf_sk_assign to reject all non-tcp/non-udp sk.
