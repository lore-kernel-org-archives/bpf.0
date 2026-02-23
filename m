Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B119D081
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853572; cv=none; b=Hp6qcdqoupEXUMCtNhKP9mFEVAXb/oAurXLvxrP8+9ZiQzeOiTNqr+aZADJ2cIo9YUK1WTGpzip00+6xf+PC1hnIqPYr7nVE31euOOJ3GT1D9TQRdZIp1jQVhgki/pJw4hX6v3frk+piqTkf3D4ihTyuaCoztY0mIUxuv247mvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853572; c=relaxed/simple;
	bh=vwDHGZkNKcZgrDUmXykErc1y/rSOex9+J/bjnc8RUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUZADHSTMETAkQ2ZTV7Rp82Ei9+08A7aQU5X0xeGtn9LOAvgUgspYz5/ekOqoMSbiYsiSiI5xZEJFkheq/D0cqgYLAD5O1bV3od6rIXyojQqYCj3VtmbzczBHyNXbLfkfc8SUYJDFC31byoL1vOvKafwuoBp2cvzSH0DmrF3X5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=meD5mbcz; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="meD5mbcz"
Received: from x1 (99.223.13.160.dy.iij4u.or.jp [160.13.223.99])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61NDWcbh055624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 23 Feb 2026 22:32:40 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=MU4uqkPCUo1YSM7ORV3XeMLzQiNwxn5T39Jw0803mss=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=Date:From:To:Subject:Message-ID;
        s=rs20251215; t=1771853562; v=1;
        b=meD5mbczMUBA9iqvN7VIexPFQB9dAqCNgFbF9AbUC6KD43CJqE8IzSY/162US5k6
         d+qoClRbskcdvG6MrTes0dk0VDvIzlVxtbWG8lTdX3+gUU76GWmW28IVReC2e+v8
         T+PPrD1WWE3EMslcCi/mRoQcYqB+CIgvGDCnaDZqn7c1EHz5nT3Rg6RKlzJZpOUq
         /EFMNM97NxBzVdqwraFhm+BxLR35C0FWi4Z5jfLnMmyFBqGaxuCfyDogGKWp+H7K
         NY5u+/xbmLSGwidcXAhjL0VVJ6hRqydACi5ryCbSxMOe/GiEMGuJ5PV9IHvVt2cB
         pNpR4f+q2PsKoxLnSTz+yA==
Date: Mon, 23 Feb 2026 22:32:38 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jussi Maki <joamaki@gmail.com>, kohei.enju@gmail.com,
        syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 bpf] bpf: devmap: fix stack-out-of-bounds write in
 get_upper_ifindexes()
Message-ID: <aZxVELsXHvrpkicA@x1>
References: <20260220193039.7129-1-kohei@enjuk.jp>
 <87ikbnofug.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikbnofug.fsf@toke.dk>

On 02/23 12:32, Toke Høiland-Jørgensen wrote:
> Kohei Enju <kohei@enjuk.jp> writes:
> 
> > get_upper_ifindexes() iterates over all upper devices and writes their
> > indices into an array without checking bounds.
> >
> > Also the callers assume that the max number of upper devices is
> > MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> > but that assumption is not correct and the number of upper devices could
> > be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> > stack-out-of-bounds write.
> >
> > Add a max parameter to get_upper_ifindexes() to avoid the issue.
> >
> > To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> > an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> > Then send a packet to the device to trigger the XDP redirect path.
> >
> > Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@google.com/T/
> > Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> > Changes:
> >   v2:
> >     - fix formatting, accounting that max-line-length is 100
> >   v1: https://lore.kernel.org/bpf/20260216201428.65641-1-kohei@enjuk.jp/
> > ---
> >  kernel/bpf/devmap.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index 2625601de76e..c8c49d86a403 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -588,16 +588,18 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
> >  }
> >  
> >  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> > - * least MAX_NEST_DEV elements.
> > + * least 'max' elements.
> >   * Returns the number of ifindexes added.
> >   */
> > -static int get_upper_ifindexes(struct net_device *dev, int *indexes)

> > +static int get_upper_ifindexes(struct net_device *dev, int *indexes, int max)
> >  {
> >  	struct net_device *upper;
> >  	struct list_head *iter;
> >  	int n = 0;
> >  
> >  	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
> > +		if (n >= max)
> > +			break;
> 
> Hmm, how about returning an error here, and aborting the redirect
> entirely? This silent truncation to an arbitrary number seems a bit
> surprising, and very hard to debug. With an error, there will at least
> be an error tracepoint to catch the failure.
> 
> -Toke

Hi, Toke. 

Thanks for the review.
Indeed I agree that silent truncation is surprising and hard to debug.
I'll send a v3 that returns -EOVERFLOW and aborts the redirect when
there are too many upper devices.
