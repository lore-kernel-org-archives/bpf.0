Received: from mail-ej2-f23.google.com (mail-ej2-f23.google.com [74.125.228.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B62E7397
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713959; cv=none; b=kv0zQy8JkBjqXXEFc1NA22lnU1xWULehuxiNwKEKW0FvtFaTOPiMKlu0DFsDfutbiS5x5V3W+q49uagcHVlzPSXWJ2CaAafN4vpRRJNIjl4kyHg3lccems9oCXTwnXo2kaVwOjiw8sDZcKkeeHsoVg82Wg/HbsDalkRrRhXlso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713959; c=relaxed/simple;
	bh=hYcGHr5ibKDvDmCykNx3vX7gSuYkKSXK1bPrWSMxwts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEm4mblGZekk1MuVEQTp1knX1mYluhzRHA4u9Oe+cnLGSltZADXesswKH2gN5bSfk24T0S8/phdrohkp3d0r+gz1NEY8yRMH2zFvI+viNkTrTsWMRgqZguYkpO+23prwWxcyt9EOzh5HX75QG+vBTqa3XlETAU1lnFG0YSwQWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z9Tj+asr; arc=none smtp.client-ip=74.125.228.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z9Tj+asr"
Received: by mail-ej2-f23.google.com with SMTP id a640c23a62f3a-c2db9cc3b45so404313766b.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790713956; x=1791318756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gjn3XbTkyEC/r4PvE0helBeSNrh316D5NMR1L4m81x0=;
        b=Z9Tj+asrbbs0RuzbTnAQsw1Huz0kGBQDMSK0kq5VFktUawva3tgu/lJvAkMZUdJzNt
         E2E+7sJAkZQzOQjXup7r6FEoHhL65jamaXJs9saPvbYMO0lR6kewaVlVvb0RqbgpKNgR
         IyCkFKr4mgPTehfyzyb+RyhlrtHdBJzgR7Omj0eFWgrpSauqHW71iyokUFUKcmz/zhoK
         YfPmwgv6v5xO56LIVADTTbrb17iG/FclEACAs8jhLrpJx7crhaVqypgEHTJvOU8vRNRH
         7D1Maqb6iFxpdK9ZFhLHzg96p4RojLFt9RqLxEnwA9f9NxJh+wN4wbbZUKNQKZKL6EgH
         hrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790713956; x=1791318756;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gjn3XbTkyEC/r4PvE0helBeSNrh316D5NMR1L4m81x0=;
        b=jVzGQsbDxisgEstY0W4UPdMpz9VSp6+klud+dJISlnunweGnDk/PVC5EhVS04cSlxn
         UfdOqqOikVeWWfNJgiq8D006h1A/8pDznd7Ubn8XSvQofa54beGdkFhZ2vW31ELOE/Hg
         CA5tgRIP9lN3Wj8C3RJId9tWPTw22ceM5+oJHDyLLkNARIkeziGmirQFLWkYgsw+CDY0
         N/hbp8AChsskWg3eMPizw1i9BLwgg8gqCcOlp2dB3WEvYPIqvmZP9NSRLWUEaZUcolut
         OZzo5Hs30R+Abz0nJrd3lZNABR65+PB27bFVqrATdYOv4V/yHEkLHwcTVgixKo6sPnzv
         iiSA==
X-Forwarded-Encrypted: i=1; AKwUvBy65S14JsDi7P2Fo9pJ6gVeG/+1YFzzv37CYrMMOF/9FXYo8jS4ty6T/3JxOhZW6dl2JTk=@vger.kernel.org
X-Gm-Message-State: AFuF++mE+CqMLoeuec4dZYXZ7Hdo2JLhWLM08NtsazvswkvcaijkkRyL
	qG1oSddBKcMm582dJam25eg18UkIPYLLggVwGyTm7Li9MtsQ1H/gkT+JfV4DjcTQC1U=
X-Gm-Gg: AYBFou1ddi5dkN5IqJAW3X49e1jFFGhernZ4NbR+WuYYSs14aasHo1DEGsNE44CLVYO
	Ao95tfsP4iDFGXtVuj3vmxWZsIdD/i2vGhZhIAf2+i1hVDm6foFQIxuKATMmzNZTxROKzQ+A82c
	xNmK+Ux24YyTXZYcIm/cD5y30VHfDHZKPOT44cJJKKRDZS45FNIMBdhGoJ2CWknprw3c0o5iBvY
	D7TWq3Kcu1gkl9OweP8hYuxftp5xAICDgfXmefA2VQbQq1FbyqGXPFAK99OpS3fuh+NtrDNxUyu
	gGTen1yUq/RTURg39T7LyWFRPP9aRX16RJk8pBsR4GEZrCKa7gYvkVqEDfBeky+Xxaq1fuC13vw
	J8mjGtuJ+qvg8pimmZhw2cZEPjUq8aeZ+k1Q02YBx9FnlBTysjNd34eEOheGqtpuxckAqDUlrvR
	ZnAoDr3P1ieVW7Wqtfe3OA30zbc8j0KXrGiiSsbBlnZqgw5dUx4G62GjYE/06ZjJHJ7D90DDoy
X-Received: by 2002:a17:906:c155:b0:c29:286e:2e3e with SMTP id a640c23a62f3a-c2e15e255eamr43800766b.38.1790713955825;
        Tue, 29 Sep 2026 13:32:35 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e1330d7c0sm25660466b.44.2026.09.29.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:32:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,  "Daniel Zahka"
 <daniel.zahka@gmail.com>,  <netdev@vger.kernel.org>,  "Kuniyuki Iwashima"
 <kuniyu@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Stanislav
 Fomichev" <sdf@fomichev.me>,  <bpf@vger.kernel.org>,
  <kernel-team@cloudflare.com>,  "Daniel Borkmann" <daniel@iogearbox.net>,
  "John Fastabend" <john.fastabend@gmail.com>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Eduard Zingerman" <eddyz87@gmail.com>,  "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>,  "Martin KaFai Lau"
 <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,  "Yonghong Song"
 <yonghong.song@linux.dev>,  "Jiri Olsa" <jolsa@kernel.org>,  "Emil
 Tsalapatis" <emil@etsalapatis.com>,  "David S. Miller"
 <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,  "Simon
 Horman" <horms@kernel.org>,  "Jesper Dangaard Brouer" <hawk@kernel.org>,
  "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,  "Florian Westphal"
 <fw@strlen.de>,  "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
In-Reply-To: <DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com> (Alexei Starovoitov's
	message of "Mon, 28 Sep 2026 16:14:04 +0000")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
	<20260925121849.2ac5150b@kernel.org>
	<DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
	<20260925132004.171b751e@kernel.org>
	<DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com>
	<DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 29 Sep 2026 22:32:34 +0200
Message-ID: <87ecebbxy5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 04:14 PM GMT, Alexei Starovoitov wrote:
> On Mon, Sep 28, 2026 at 05:52 PM Jakub Sitnicki <jakub@cloudflare.com> wr=
ote:
>> The correct results - as in reproducible and with lower variance - are
>> the other way around - BPF skb ext is cheaper CPU-wise than gated skb
>> tracepoints. Please see:
>>
>> https://patch.msgid.link/20260928-bpf-meta-gated-tracepoints-v1-0-844dbf=
3e1edf@cloudflare.com
>
> I don't think these numbers measure the mechanism either.
> cpustats.py divides busy by ncpus, so +16.4 and +6.6 are the mean
> over 6 cpus, while 146k pps is the total of 3 flows.
> So it's 6.7 usec vs 2.7 usec per packet and not 1125 ns vs 450 ns.
> That's a lot for one kmem_cache_alloc/free and a 16 byte copy.
>
> Pls share perf report for both and rerun.

My mistake. Per-packet cost shouldn't have been normalized to CPU count.

I grabbed the perf reports and flamegraphs, and added another variant to th=
e mix
with per-CPU LRU hash instead of rhash to get an idea how much overhead com=
es
from locking. Gated tracepoints + per-CPU LRU hash sits in the middle with =
~1.5x
the cost of skb extension:

| variant                        | =CE=94 busy (mean/6)    | ns/pkt @146k |
|--------------------------------|--------------------|--------------|
| gated tracepoints (rhash)      | **+16.4 =C2=B1 2.8 pp** | **=E2=89=88 67=
50**   |
| gated tracepoints (percpu LRU) | **+10.0 =C2=B1 3.3 pp** | **=E2=89=88 41=
00**   |
| bpf skb ext                    | **+6.6 =C2=B1 1.1 pp**  | **=E2=89=88 27=
20**   |

% of perf samples breakdown looks like so:

| component                              | cnt  | ext  | gtplru | gtp  |
|----------------------------------------|------|------|--------|------|
| tc dispatch (`tcf_classify`+`cls_bpf`) | 0.08 | 0.25 | 0.34   | 0.88 |
| skb free path (`napi_consume_skb`)     | 0.05 | 0.09 | 0.16   | 0.31 |
| TX chain total (`udp_sendmsg`)         | 2.51 | 2.53 | 2.98   | 3.27 |

Everything pushed to:

https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile

If the numbers look fishy, after Plumbers I can set up a proper
experiment in production to see what the CPU overhead is like on bare
metal.
