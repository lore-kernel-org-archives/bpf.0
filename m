Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C83B7B71
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944678; cv=none; b=esnDfd5ODTFU8OYo0GoYcc3VaaN9GABKZ97VgtycqCxsC1hLyGCd4+ofF6ROvy/VxRk3bkh8Wf9QlsGtwnm26hVPnroKzDbKQ/ajM9AdwC5lJl7/En3BVvWqNP2WU2FihUe95/g6eOWZ+Xmc5ZqHi8L/j9krJ5zP1ig7nT+qsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944678; c=relaxed/simple;
	bh=GWXc7aqz+JP/62ObxFDdswrcYFvTCyfgsbz2ENpfWG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUKHzxY2zx05sTQYRuWL+LMJmu33/JoFT7Lg4ZF7rQmFDg9t7SWAbOs1LZ6bFy39wPjwVXUbOLjX9CQ75DKhY1n0YR7rIHijpxTVhr5pCUX4/w983RCIFcxH824z4aQy21Ed45NSQeFF+Gq4JSKksXRsAX+QIt7fWRDcpvV0pXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SFDKTC6H; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SFDKTC6H"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e23be09baso376353966b.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790944675; x=1791549475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kPQTISOHvgDFG/D95e14Nk4IcEq4M+yFBnxlnHIdm/8=;
        b=SFDKTC6HwKmxzD7/xNibsBFc1j4ff+ojy95mdWuV2mKncK/mBoPjEvtfJRfmqAUALx
         Ohy/vqCmHL7NIvX5ZmxBKkHXxmiK0SpR9nYt7WBDwsV9UDGYJjF+v0jGzkACnWqzhw8g
         6RoKhAk53wWP99L2ndduvSZ5zJ+nAWbMMFVImoRxxNZpMUqYExCh61O1ZPcReh0Npu6V
         MjtsplDWVyuKY/jSOHRR7hH5KXJfPP5H0/02j9FNoO1zv4SsPW8ZNQRdjx8+/N03OGPz
         MwAgaEiWsYaT0s9M8W992j5qvo2wwAGOc83rQJN/kHP4eT5RE998BaqIHRJO0ie1ctar
         DpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944675; x=1791549475;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPQTISOHvgDFG/D95e14Nk4IcEq4M+yFBnxlnHIdm/8=;
        b=gFOTH8S+cmsY2YJumLMMjOBU6y7Frm8GeT9hhjXCkaT32WY8irutBPGoi+/3fUWV0+
         MTDcIOuQBxtO+5yM9ua6GsLYvLT8umxnJ8Xp5affgd7FEQXwogWQHYGSVh5r64c1XqnI
         T4nbg0vUIg+fg9z0NVZhF1qwxXqgbD9q86zLQtHd0JW+2o0dBbwoU9FD/ATJX9Tl2Z5H
         LwvmbTS1WuXX+D62jb6s9K2mpsO8tbT7qN9Jprov0Jt95SoyRLw3W+B5yBQewJ2wZw2s
         P+Fni+Iyt4PAW70RZnA6v0YDZsLZ04afTxf/KzjkK0mq2Zozpg8AOTcJpzHoFehsYHeC
         u5+w==
X-Forwarded-Encrypted: i=1; AKwUvBz6qdXyReASubpZ8WK7xeUlOotaw9JbXeJAdswm9Zo7R8dijKWJxJStEAv6VxJzxx2y53k=@vger.kernel.org
X-Gm-Message-State: AFuF++kuOMTLHFODWjV1immI33ynj/tnkEZfCNC7uE6EfRZlQv6v4km+
	eqPALTIVcQrdspHpMVykA9Ja2Wi+Mhv3/KNAUTiF+2erP8iUVDCPcEoVZaJJBmFk9dE=
X-Gm-Gg: AYBFou0XJ+ukR/E8SyELQBjLmcP7py6eYaGhW46P+BjCECFjP903Vnl6GwP6qGJpxLC
	67bGV0aIRM2UcFV/eXOVnBxpGa82Wngqb1Y8DpZrTDhpZFJNF4jG7vrZKpld4W3KCXhlL5QSyfc
	dUP6fp1l/CCVLBcFYsmfNbMX3DHhGIQzt+bANLTIGVxJrXGbWaiLHhmZPo4pXn3tDJ2ctHDo/0x
	I/8r62mkg9+1p539ZctO4gnjmTa6KQG1Wt1/2whzhKiw950DStuQW1g9PUklJH5v23CjYJ8mEer
	mLeH7vC3NeWHwndefSLbg1O06MgrD0oeNdI0+44f8vua7NREPB7f/0dYppeuvcmiQeWza8m4s/9
	/ENs5kr7sZG5R4/uKSdkvDRaUCDDBrMmjabZ6JHnzP/nRXt+tTVconv6WHPP9QCFLh/E62Er5c8
	Lt3cyFh8ILzLvYAJRn5H12+GeB3xj01J2Nzdadj86/9cuOVVAQqoCwGrMn4Hl5YKQ/AylU5P1x
X-Received: by 2002:a17:907:7a13:b0:c2a:c6fd:ec6c with SMTP id a640c23a62f3a-c2e4adbbb01mr209234366b.30.1790944673795;
        Fri, 02 Oct 2026 05:37:53 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4ca4e2d0sm84749966b.4.2026.10.02.05.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:37:53 -0700 (PDT)
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
In-Reply-To: <DLSJ0UIY3DSY.3JWS6CS3TX0IP@gmail.com> (Alexei Starovoitov's
	message of "Wed, 30 Sep 2026 09:00:23 +0000")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
	<20260925121849.2ac5150b@kernel.org>
	<DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
	<20260925132004.171b751e@kernel.org>
	<DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com>
	<DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com> <87ecebbxy5.fsf@cloudflare.com>
	<DLSJ0UIY3DSY.3JWS6CS3TX0IP@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 02 Oct 2026 14:37:52 +0200
Message-ID: <87ik3kl1lr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 09:00 AM GMT, Alexei Starovoitov wrote:
> On Tue Sep 29, 2026 at 8:32 PM UTC, Jakub Sitnicki wrote:
>> Everything pushed to:
>>
>> https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile
>
> looks like you had lockdep on, so all the data and conclusions
> likely do not correlate to production.
> Pls fix and remeasure everything.

Thanks. This makes much more sense now.

1) Lockdep was on. Fixed. Configs published to [1].

2) Switched from mpstat to bpf_stats since bpf-skb-ext cost was so low
now that it was drowning in the noise. skb extension teardown is not
accounted for.

3) With rhash, I noticed churn from auto-shrinking in map_update_elem
(can be seen in gtpchurn profile [2]). LLM suggested a one-line fix to
set min_size from map_extra hint. Benchmarks ran with this patch [3].

New results (prog runtime from bpf_stats in nsec):

 ~/bench $ just bpfstats
python3 tools/bpfstats.py --agg results-1 results-2 results-3
variant          prog              results-1  results-2  results-3    total=
 mean =C2=B1 spread
---------------------------------------------------------------------------=
----------------
ext-cnt          cnt_ingress            35.9       35.6       35.5      106=
.7 =C2=B1 2.2
                 cnt_egress             70.3       73.5       69.2

ext-ext          ext_write             199.3      198.9      203.0      263=
.8 =C2=B1 1.9
                 ext_read               63.1       64.1       63.2

gtp-cnt          cnt_ingress            34.4       34.3       34.6       94=
.6 =C2=B1 2.5
                 cnt_egress             59.9       58.1       62.7

gtp-gtp          gtp_write             531.0      555.9      567.2      920=
.9 =C2=B1 34.5
                 gtp_read               85.1       87.5       91.2
                 gtp_skb_free          267.1      283.9      293.9

gtp-gtpchurn     gtp_write             784.9      782.6      830.6     1190=
.8 =C2=B1 44.2
                 gtp_read               82.5       82.3       88.6
                 gtp_skb_free          297.5      294.7      328.7

gtp-gtplru       gtplru_write          394.9      391.9      394.5      542=
.8 =C2=B1 1.1
                 gtplru_read            48.2       49.4       48.9
                 gtplru_skb_free        99.9      100.4      100.5

gtp-gtp is with nelem_hint+min_size hint set.
gtp-gtpchurn is without it (map_extra=3D0).
perf reports and flamegraphs also updated [4].

[1] https://github.com/jsitnicki/skb-metadata-bench/tree/main/configs
[2] https://raw.githubusercontent.com/jsitnicki/skb-metadata-bench/refs/hea=
ds/main/profile/perf.gtp-gtpchurn.svg
[3] https://github.com/jsitnicki/skb-metadata-bench/blob/main/patches/rht-n=
o-shrink-churn.patch
[4] https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile
