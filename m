Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AC35A385
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147618; cv=none; b=taeU7pTdm5KVTmYJVZZbu5mV5V443LqWuQHF8J8CVJGKY/+GyX10dCYnKvM/ZDuI2JQnhDRnpGMVBWTG3ypB2B8GMZunx0yq8BIECMtExsm+vrwzevkTh3SSRWJQqhQzvB/X4D2Hk/JPZOt9N6No9Kku30uE2mPeAjIqlz+J69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147618; c=relaxed/simple;
	bh=HiR6pJ9fm9vELo1xCF2Qx1WeuzJdT74DCjh5i7cbV54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grxb3T78qXF2YuQf42/YmMzXMrew82Y0TlkwoA8QCWOBjGkW/K/wSzPhCDW6B7vDzJU4Rpp8ydDWVyGcA02kWVR59e/UgD0lTRpcNe7O2YRMChe5ZkW1injY3Qjt2M4pcnOfOJOpsYtUokA0n4eLIODTzctwuSMqpOPL1NrStE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaTnzmP5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaTnzmP5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so9232115e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147615; x=1775752415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCmrKA4KmcKXM5NFEN+Ile+o+0NgwyKQKKIlcQdnZcQ=;
        b=YaTnzmP5sl+dTKpr4KXVkQs4ZC61BI81wZF/45XQzXWA3XYeUIrhgBApeTQsvnAYJ4
         cnzqxYIlAz40Ikjgd1lCs0wqQr6t8euYtDiqPzm52gRtqD/K2uCbnH8nkq83QEqhQ7wQ
         nByka3lXSmBNE2r/rC0mY3B4mK9dS2j/voCwFEou5Twn3//GSH3rd/FNIC4iD3TNbg3g
         1G88epRSbSefUfS2TI+UaD5ZZPIBfy6ZPX+09Rnk28x5zrk7RljmLcjn7w7gerDlPtA+
         HBdTA4GCDDj+Q7KfRW8DjJkXOeM5cmy2uTzN5F2ptdG8Jex+OskYMAYR2i2Kvpgej/Vp
         XStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147615; x=1775752415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCmrKA4KmcKXM5NFEN+Ile+o+0NgwyKQKKIlcQdnZcQ=;
        b=NyvPcOfDZuB2pIoUOxqr4gzTC62tMpRxNVJBwYfqPdSngV83h6YvMQhPH44MASLsWB
         6guMULzTKPoW87yOX6ER4656rOrb3q2fbJDsFl2JmyFOWTuKlVAXibyn2r4z9iHw7KsJ
         LaTqXyda5XUA18LKgkb3iOo+STXukOmAMgIeBjM5AJH4hjRJakqvqHunvAXCzkHeza+2
         T7UCOSDTTIBV2t69g8VR/s1GK4Ho+Q8xmfEEzuKlPXbpkf+YUOdFynGPrV/XqRNxjWXJ
         BXCMSaNUWy8cx4A/kB6Cb2TzLbTcz279orHWckiRdtinHa9fZwHQW9TeK9m5mMWS4/+w
         +P1g==
X-Gm-Message-State: AOJu0YxVRS4SmFRt2sHPffrJ12/H97fDYezz55aZH98Rj+ylmUfAl1Xs
	879okq5IyS6DA4RQqSv8REDQMvQWWKFVLHaDeztk1CZpv0KU8KMHyzAc
X-Gm-Gg: ATEYQzyamf4FH+dV1PX29/jSChnGjkbtJZ7pUwuo5PCm5f07Npz1PzIzuaeuLdLvdkh
	jalX5/xyHzkSCOfrtChn3YLKqrjwYJnRuSEU25FGWwhhfuQI9jDhvKurpyvG8I0wbMUOJOiJEip
	zUdPcnylK5iucjykEEjx4QsbzsFZZ+kMQou85D+r6u71FUwW7TK64VQ+b9TlhcMHaVtQg8AA5Ox
	uHtGfEMVeNaq3jpE2JSbsm90QOEaXrgZfs3ODNMx8/TfW4zWsLyiXMazD9SDHIpQPO+6lW7drum
	DbxvBYxmHGqY2hINYxo+BGntbsbXO/WoFMh/j9ehuNnEE8tj+z1hWjE2ERlk/9mwmNUkqmADlxX
	EdAJzD+y5IMcqAi7PDW2Tbwca1lzO1GBwdhNKva6eyGUUGlvldUsfb2TRUdKBFITMQyV0baKQgv
	/aQ36P1hGYuNNOZPUYcaXRwhqR2jnIUta/DkEHzY8WGEcBQc9I1spvwzg4IW7p7MtV6nU2szK80
	mh1UiNo+JtA1yI/0ZOK9kbmaxjYs6lzR/v1AgwTpcJLXNfuBtzPk9fuHoMOa406e0PJBzdI/+Pg
	brhJwhhPEz4TGA0q5IwK3oApG0Z40UbxoV97wyb9qOk=
X-Received: by 2002:a05:600c:8903:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-48883595db7mr110222715e9.21.1775147615297;
        Thu, 02 Apr 2026 09:33:35 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a705ebdsm92624255e9.10.2026.04.02.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:33:34 -0700 (PDT)
Date: Thu, 2 Apr 2026 18:33:32 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, harishankar.vishwanathan@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	shung-hsi.yu@suse.com, srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Simulate branches to prune based on
 range violations
Message-ID: <ac6aXEuufxIYKgO5@mail.gmail.com>
References: <a166b54a3cbbbdbcdf8a87f53045f1097176218b.1775142354.git.paul.chaignon@gmail.com>
 <3f23feac390f144ec5e47178bcc0ca5cb774e093d2d1ce6675b0b31fb4c9c95e@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f23feac390f144ec5e47178bcc0ca5cb774e093d2d1ce6675b0b31fb4c9c95e@mail.kernel.org>

On Thu, Apr 02, 2026 at 04:28:30PM +0000, bot+bpf-ci@kernel.org wrote:
> > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> 
> This is a bug fix addressing verifier invariant violations (e.g.
> umax < umin) triggered by syzbot. The v1 of this patch included a
> Fixes: tag pointing to 5f99f312bd3b ("bpf: add register bounds sanity
> checks and sanitization"), which was dropped after discussion about
> whether it pointed to the root cause or the detection mechanism.
> 
> Would it make sense to include a Fixes: tag here? Even if 5f99f312bd3b
> only surfaced the issue, having a tag helps stable backport tooling
> identify where the fix is needed. Without it, automated stable processes
> may not pick this up.

We discussed it and considered it best to just drop the tag. We believe
the automated stable processes will likely still pick this up
automatically, and if not, we can always backport ourselves if we want.

> 
> https://lore.kernel.org/bpf/swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo/
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23908257980

