Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC8313540
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116172; cv=none; b=MIyBS33mJbNtx2wkTNEiZqPWfkWhseFRpe1SKTHA/rle5k5t//aSf7p6CD3Z+/pAMe3zhd2+7gGXC4Y0msmDeO4+SUvGeL9sJEpMWPHVKIlhLC1h8Iqoa+uY34znhlhLqMmG6OgEaazfWQCpZv5RSyIcigDMGGxhxEBIMAXHoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116172; c=relaxed/simple;
	bh=uh4vMZHDJWALVYoPUUN93q7NYxmca7wUPho+CUVVv30=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=L+ziuRSdcq0mlMJd/ng8G+ERg+mp/ZpOsZeWtyZPe/NC+QMlGu4x30CsComiwkQqunK+/4IO/mOvoacy0t7Z78sHb0FcJu8StIGPq1DsbDENRF54+UjaCMDk3VCO9OA+V/OQePJV2r3+QQHHqEFy2q3fj5+UeDYZxsfuMhkUwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQJCci+s; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQJCci+s"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab3260b2cdso2710332a91.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116171; x=1792720971; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbIRf+Ho4UGxQsrSILPqtfz7fAEmGCzY2r18bO6Pi6g=;
        b=iQJCci+suaLo8D5p/YTqg75z06Dcu5uJJ8IFVhlSIDULSLa0S+qWpvQAXbe+N0acZ5
         GPuerDbKcgQnPf9n+yGuXw/N2P0FAu1jcW0qqFXibHUkix3sCqShjr69FMGmwTjQJaJ/
         YTeYr+YFkkuHWeeuAiaFUZwtblJhDBtJ6G8X0MxGJk0unEz4LZuS+WhYdjZIQRoTWr8T
         5fhSfW1fmEHSceRXBnt05dVBs2RCEpvo9wKO9w8TgF9igaWSUBYR3RhqkZsqsc2Vz5Sz
         O5X1ovGFgQqCPv8u1Zv8/ZV24swurZcyHFZUscUcieyW80jkaKSWYxb5yDOYxQrUkIBq
         YxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116171; x=1792720971;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbIRf+Ho4UGxQsrSILPqtfz7fAEmGCzY2r18bO6Pi6g=;
        b=eQJiqLUO9ZfWXy88uqsQ+VNrfuCrSidPK/l4jBT7FYYajN1NSzAdwRpHDFr0zvMhHJ
         gRE9X6xwABI4D7bOzksPvC+/eGiJx4Kac4b+FkVkWkvuZRk5Zbp/53z0KXvfw8lXqQCO
         cvODWwewxlkmMLXmxpOExgbzyXVFaLNBs+HnNi5sRGtOZzO/BB1i2/K1eJ6GJS1iHj8g
         osjsyyy+H5vx2P1fxrl5BnJecbuWktEO1iioy/iu6hNpkQKzeljR2HdfHW7s1sPMi5cW
         jAazs+NNmNiPbpP7u2U0OJF20Ob2noFKJ42C8+THMcI7Xqp8LAYK5hSdJ/RKW52IrDsG
         Easw==
X-Forwarded-Encrypted: i=1; AKwUvBzVdwHPKs8eawhv5H3b/oQvwelvh4IAHjqRntwBf68WjY2/JZrMPLovOWnV+TY8I85CL14=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrBz6vwvCpqE10yoKfk0w9uyiD8iZWX8EEn1aEmaHGwaQ9U1zY
	iVqDUyVlNz4E3JA2t3X8fQNrXvBnXnroRmntxfZLkEbbhrQ5RHURV/h1
X-Gm-Gg: AYBFou2Sl/cYC7IRd2mCZJAPLztLZlp4yP0+74iBQq4C4N8lEkPTzi2SAqV0utixvN0
	gDdHd4m3V5i1AMydI6U/0ufS/sJRbJAdYowKGxdEO02xgSSffajzgD1J51M8kltUhXXwu5jWC4K
	xylqlgWiEwBJlHpUjLZiY/R+iWCuswjHcIR5iTodxi1dn9VAqQRgJ0n6Libzm9w/shnVLBQcAws
	JjOza/LcQnUOVj93VcLVdEdZ0uU2qiqPEJL9EDHtudFEWHNUSuqfhdLAHlbKIt1g//B0bw7E2Vu
	UTgWmKGqlgCfPA6weRXjuR35GEKBzTGsrqDMEyjMybTgsjVs66u7pgsgsD83yuXRn9QvO7eJKVF
	GGlsRv0U3WeUUZtH7YxAImqjB6YAyPQSHNEKbUJB8YAVSgN+oih2fHaSHXjYIGky2RpyK8bFeyP
	k1+69MhhHQm/HgwfBA+eXjcHW0YGyT5QHl/btouoV66f8d+zu78Qy8mlm/aPqCOj6HmamoE8q3q
	04Lar3y9iMxQ3gsjqjjcLHIXW+jHxff448rchvrdfQqw1Fug5eRxz7N+yPi56wGTrdwaxtz5+de
	48w=
X-Received: by 2002:a17:90b:54d0:b0:3ab:4e4:e979 with SMTP id 98e67ed59e1d1-3ab3ac90725mr15693947a91.36.1792116170710;
        Thu, 15 Oct 2026 19:02:50 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm6566855a91.13.2026.10.15.19.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:02:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:02:49 +0000
Message-Id: <DM5W5UNBV54W.LJ1K9VUN2S3S@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v4 6/8] bpf: Fix arena race between page free
 and alloc leading to incoherency
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261014233442.8392-7-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com> <20261014233442.8392-7-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> @@ -1063,23 +1147,51 @@ static void arena_free_worker(struct work_struct *work)
[...]
> +		unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
> +		if (!IS_ERR(unavail_node)) {
> +			s->flags |= ARENA_FREE_SPAN_RESERVED;
> +			goto clear_ptes;
> +		}
> +
> +		ret = PTR_ERR(unavail_node);
> +		/* Retry without starting teardown. */
> +		if (ret == -EAGAIN || ret == -ENOMEM)
> +			continue;

v3 dropped the span here. v4 puts it back into free_spans and
the worker does schedule_work() on itself until kmalloc_nolock()
succeeds. It's __GFP_ACCOUNT and it cannot reclaim.
At memory.max the arena cannot free its pages, because it cannot
allocate a range node, and those pages are charged to the same memcg.
The kworker burns cpu in the meantime.
In arena_free_pages() -ENOMEM goes to defer: where kmalloc_nolock()
of the span fails for the same reason and the pages stay mapped until
map free. Same as v3.
The free path shouldn't allocate before the ptes are cleared.
