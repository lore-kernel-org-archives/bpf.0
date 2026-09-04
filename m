Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BF3B19BC;
	Fri,  4 Sep 2026 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491854; cv=none; b=VbOmNmD4aRwKm3C+ty9HI54/KcmH5eAIhbvc6UWzpxUUBBZzPK558ttJ0BpsIiuitlh56Gfo1W61gQOFdW4joHwzGIrkWnBcChDDkKzVi/AdNV9VadactO9k3QooSZFFf5g8JHNSv0fO9WzihvihwoE2wKDEuZFCZphhEpEODxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491854; c=relaxed/simple;
	bh=UuVs6G544DUiPcB+LIxKErGL1C6sWz5vsMOXhTDol8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3KmRew/RbMriKOdYz04eE6Kb8TZRwiKPBV9aS8QF/WXij2Lqti5zgnO5Xex8GUk97LnYXxofrxgulj9p2mmpJLQCFU+JG/ohPXnG8IxJqwMwiaB0FqoCgRrHcei8fadJhfk9/PjQFgrreuaoN3GFSKzkY77DUoOACyc/MYxWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oz53q1Nm; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oz53q1Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Uu
	Vs6G544DUiPcB+LIxKErGL1C6sWz5vsMOXhTDol8g=; b=oz53q1NmF/PUWgQynL
	id8zjm20GI46Y6hDp/emBeqjcuHeAVlnJfVmmvH9BLdopE/+alAqv5Z1ih4b5Mme
	yEoVPr+e6mMI9ZTuA9WyXdUmQQrCbHPFgTQ3dBgzDS2oK/SwmFAEPkMW8KH+xdKP
	91xx+byVCn5Adtwj4nxPz6Vgs=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnyPcVOJpqO20qOg--.45819S2;
	Fri, 04 Sep 2026 11:16:37 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	bpf@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	yatsenko@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: bound resizable hash map iteration
Date: Fri,  4 Sep 2026 11:16:37 +0800
Message-ID: <20260904031637.230595-1-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7c741628-c259-4ae6-8d67-d92910183526@gmail.com>
References: <20260831140132.117755-1-sh_def@163.com> <7c741628-c259-4ae6-8d67-d92910183526@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnyPcVOJpqO20qOg--.45819S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW5tr4UZFy7Cr1xCFy3urg_yoW8Cw1kpa
	9agryktw1SyFZ7WrykuF4xW34UKFZ3Ca4UtrWUG3sYywn5GFnFqrsrK3y29FyUur4xZrn0
	qFWxKwn8Zw4rAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRo89ZUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRZUs2qaOBZLmQAA38

On Thu, Sep 3, 2026 at 5:43 PM, Mykyta Yatsenko wrote:
> I'm not sure if this change fixes anything, the main issue of walking
> concurrently modified rhashtable is not changed: you still may miss
> elements or visit same elements multiple times.
>
> In some scenarios this can make things worse: imagine you start
> iterating with small map (visit_budget = 10), then 1000000 elements
> are inserted concurrently with walk, so you'll miss at least
> 1000000 - 10.
>
> To me this is a trade off/taste thing, rather than bug fix. The
> change is compact, though, I'm not against it.

Thanks for the review.

I agree that this change does not, and is not intended to, make
concurrent rhashtable iteration complete or duplicate-free. Missed and
duplicate elements remain part of the existing best-effort semantics.

The narrower issue I am trying to address is that bpf_each_rhash_elem()
currently keeps calling rhashtable_next_key() until it returns NULL.
The rhashtable_next_key() documentation states that a full iteration
may not terminate under adversarial or sustained rehashing, and
recommends that callers bound such walks externally.

The purpose of this change is therefore not to make the iteration
complete, but to provide a finite upper bound on callback invocations
under sustained rehashing.

I agree that taking a snapshot of ht.nelems makes the bound insensitive
to elements inserted after the walk starts. In the example you gave, the
walk could stop after the initial occupancy and miss most newly inserted
elements.

Using map->max_entries would preserve more of the existing behavior
under concurrent growth, at the cost of allowing a much longer walk for
a sparsely populated map.

Would map->max_entries be a more appropriate bound in your view?

Also, if you consider adding such a bound useful but not a bug fix,
would bpf-next be a more appropriate target for this change?

Thanks,
Hui

