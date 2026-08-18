Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0071F3BA2;
	Tue, 18 Aug 2026 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787013399; cv=none; b=pTkqtm95OZfIgAb6frsShOS2kkve2jQ3iaR2irbdf3WoGpo34cHlfmb3rIHqp3uS03HywAXUspi2AaMef4dW3wwrPP1XeAy0WoL0obnYRj/3F+6ygScahaUTsdo0tvd8iBjDYCima/H3LVUqbnlC+1PdidEAFCn6TxgfqO26bHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787013399; c=relaxed/simple;
	bh=K19NCVin5RCLwsF2AtP/SmG2qXzhUI1fxKo/AcNDKVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cgft8SdPBYpHfsZJwcnLPj6IUUG4HGcnAcaVL9x6XPMlUZs7zaGQJ6ltCYl7UElLT/ISY06z4pQ5l8cxPZvPWqs4G7mP9eR/JRX+A2EG1P4RIs0zGjPKvh05/t+tHXU5rIUFmFHWtsqtSY2KoXZFLnN1h8clugsMnyaDM0bgh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po2p5XlP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po2p5XlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5A41F000E9;
	Tue, 18 Aug 2026 00:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787013398;
	bh=cR830xQ3a8bA2McZo4Bp/ee5+cdG4eJqo7ZtwSOyRAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Po2p5XlPCDHzoNvdCA0TnokD1GiC8+qiabnzakKaj6r0uNQeYtK8/EeTzQWT6yWr3
	 /6GOexEfkIs6i/TVgTJe83VaCLHVhASFxqc+/1Ey5TbK5SLgOwBDzXYFlaiUgpIctA
	 opyBxNQHFgZ0DsfygZ3S7f41fyigYmUrBhusHGCKraM8g+Z+rGpUhWmdw3DkB35xxg
	 ySKeVb82K/eSF59l8VA1ke3NlGWjLfr3H5s9OLB92ValhLbk4EH1uw1yQUZ4exFtXY
	 LJQoIa7T1ZvJ1KLY7IBSpbSeRRYNMi/onuKZtYJBdCdynCGxQbOHSzfitBZVn4OyI1
	 7UvJbFjANAF8w==
Date: Mon, 17 Aug 2026 17:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org,
 dsahern@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, donald.hunter@gmail.com, kuniyu@google.com,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v7 net-next 0/2] Explicit TSO segment count
Message-ID: <20260817173636.0202325e@kernel.org>
In-Reply-To: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 19:30:32 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> Please find the v7 explicit tso segment count series.
> It replacece min_tso_segs() with tso_segs() CC callback and make
> tcp_tso_autosize() available to BPF congestion controls.


    progs/tcp_ca_kfunc.c:115:15: error: conflicting types for 'tso_segs'
      115 | void BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
          |               ^
    progs/tcp_ca_kfunc.c:95:14: note: previous definition is here
       95 | u32 BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
          |              ^
    progs/tcp_ca_kfunc.c:115:15: error: redefinition of 'tso_segs'
      115 | void BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
          |               ^
    progs/tcp_ca_kfunc.c:95:14: note: previous definition is here
       95 | u32 BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
          |              ^
