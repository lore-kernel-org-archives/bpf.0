Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017715;
	b=ETsBgVVeyAl0zrqSiO4CvC6VnJV8rNhWWCFN97AhrtehgTE/TUlAT9nd61uiVNK8Wf1C
	 heqbY1phAWE7JawG6KiTMUPjGUMyOMWpskbgLG5vK1ZsV4L5s54AjD9q320BIv9lleySQ
	 cx4iyuLeOuuSupJevAryODpRcxfpkuILS1ctOECy4MISpwQhwKTfFsFC7JhKaON9OQu/a
	 tcmwshnGX/OHBwmttniOqe8o+PZ5TdA3JlEKM1XNTLfWJz6+93dNFex9+0mmUEsBP4TpG
	 bP6cnntn1YBjRIALkaEilDXGbhSVp8YOz5/J/0fsTLAcP9zEFL/SnbRqTa+2D01+5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dc9ewNRLy/KDUCgVc1zw7V1amTwtToITL8ldPoKTuCM=;
	b=fF2jKTMtP/gaLd8ORspum3GZ/rcOxLmOwfW4tVLOjOfp1EXLNF/glhmk1GuxxHpxu2LJ
	 NAgftXzUsRwiXGLMvFGwMT5ZsgWVxf9+/tJrrguJObi1NFkazbST+JVS5jHTzDNs8jeBp
	 D2bWDc7lxP6hRlMuO0APUnMCDYAFtrS2h6ZSkuzxSLZqUn2fgyciejC84rt5i/Mj4JfTH
	 rOSqmNAnEUltUU8BbTTPwvnWuvYkRsKz6tsD577tqEYKCI9Wqjowgv6lR4oubD4HEb2g2
	 z1Bpgfn6woy0aYswqJCqrqO0GYrnyKTsuXJTFJ/XT25QuHghoD9cq+K3xD6wDBPF+sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIaRJUt1;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EA606A334
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 793EA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIaRJUt1
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-49134c8509fso1032880f8f.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017714; x=1794622514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dc9ewNRLy/KDUCgVc1zw7V1amTwtToITL8ldPoKTuCM=;
        b=rIaRJUt1BdlbukYtOlgR3hm025ZNxYq1nfZwPggR6pcX4cUfW1bglCbWsHSd+L52tV
         HfldkHEXIy5xOOmVeJNMVbBwBw/0j4C6+rZLgGNL8So6zZuq8zzQtJ/0cXKKtAFvpDBU
         2myzL2JNjUfhwPRdmFOizDPdbiphF2ebjRezj6BBWKc5zDn11Y5oQAnVNvto5HDh8hNc
         9kiZFkhTNmnO1W4Dcf6YFvC11fLhCvlKM0AWrovMXtIeWKuEpJdEkTHpR4tAs8bD+X8G
         Msz2L5oR6NOlBGlsoHP4dK42na52GbDAMsKSIW3MX/S4RmPwd02Akx3FVcKEZVYTPj59
         A8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017714; x=1794622514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dc9ewNRLy/KDUCgVc1zw7V1amTwtToITL8ldPoKTuCM=;
        b=UXztSuvKUOd6eS2/AqqYX1QhsrMRBBu/ODcBBXc9qwVTOaiq5mNI+E0wiozoObvnLs
         vndauWUAzIMnQeDWboWgTYyJPnV6vlbnLZqj0RnUojR7R/PLvbcYHehJfSV4uMfDdL7o
         U1RxzF55Irf9GuhPzP39INFbX0KuE5hCFYUf1TfSWgYTZs93ho/sBiNYqI9PlyvDAvRh
         seKHDOt2PaWWR1HjDQ1vdDyz81INKzBN8OimtymskQDzSUxoXn5r6FVTToadOD9TY3co
         Ar81H03OflxrdoVUc6wigp0JfC/SO90pc7VpoARAbmEEylbI/LGOtaenNkdxLBFWGiw4
         n6PQ==
X-Forwarded-Encrypted: i=1; AL+hErHAmewaLx3pJqXnPJraHQleb6aG0IiuWh4GfsGqZq84YpLQDxcvVaBJ9KxJ9pSqWZ+Gkgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fkgb6T8w4HeRkJ6tbDkMTQ/MFkp8vRA3YkIEe5KbBQ7UT5gS1
	dqF62srsoKNjpwJJkkuDe14MBVMb/GV75BPXIPn2gpvTKLjmdZ/m3p7h
X-Gm-Gg: AYBFou1G11GvZ8m7iIWd1itx4rOTOwsxloqcJGMCkzE1NZnoRD29kVguLMRRJ573xxe
	2uRv5ny5bC2/Efahp5VpMoQoXPaDKDP6C9ySKF4rnya+j2UY/4eC12Z8h59fHelUQXuGFbU853f
	aYB92sdDOS5asQfaVNKwXhSUK6ja/QfT0ZPnYnAtAS9uwst2fAk0pLva+XgtPp1htxtpwthKKBY
	URfxBXJR/W9CnR/r3VHrBf5hyjW7wlGZXIk6DjFZBaXzZmbndLWMT94thg5ZgULWzkjnePrMri4
	V/PUXMzNMjEsvmNrBCcQJT9jc+q3cxruqJOCSE7xa5n3ha6NzngjBTNByx4jP0Ioa3epmAEOsFk
	F0aVQ3UngCBQg+G1U/8qpHff/8ZQIxOQH4tMLOhwzpoe4bwhXwtt2s7oSnXQ4alQAkzFeZMLIqX
	Ay8FoJ9jnIZI2+qhrrsQlBaY+xoXo68LBfy5ftUOnX2sNbtSEhA9+bTheJdblhhGKIn753TCF2S
	+7qyyypcFGOlkjFswJ5rIG+nJ9fUJyMRCHgG1+xM2GZ9yhjBN1tDedM11a+C9OYByMGIX/JMUHf
	CicJOwW5Wu6iVWSpTwe1CtFGvvtrItnDfG8r1rZDHFfbBwrsh2xkuTx7PQItqkigD44YIn6AQdy
	AHzd36LW+4ztowSdK+Xs41ys=
X-Received: by 2002:a05:6000:41c3:b0:48b:108:48cf with SMTP id ffacd0b85a97d-49275b1bcfamr7936541f8f.25.1794017713547;
        Fri, 06 Nov 2026 18:15:13 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:13 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	tglx@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU
Date: Sat,  7 Nov 2026 02:15:06 +0000
Message-ID: <20261107021509.968928-1-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au4HhnJoKvJ6GPJT@slm.duckdns.org>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-2-radu.m.toader@gmail.com> <au4HhnJoKvJ6GPJT@slm.duckdns.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 06:59:50AM -1000, Tejun Heo wrote:
> Thanks for catching the bug. However, this scheduler is more of an one-off
> debug code and I'm not sure we want to carry this in tree. Maybe put it in a
> github gist or sth and point to it from the fix patch?

Fair enough. v2 is the one-line fix on its own.

Rather than a gist, the fix points at the v1 posting of this patch in
the archive, so the link cannot rot and needs no account:

  https://lore.kernel.org/lkml/20261106094343.174905-2-radu.m.toader@gmail.com/

One offer before I drop it entirely. tools/testing/selftests/sched_ext
already carries nohz_tick, which asserts that a finite-slice EXT task
restarts the scheduler tick after an idle interval on a NOHZ_FULL CPU.
The condition this scheduler holds could be asserted there as a selftest
instead of carried as an example scheduler in tools/sched_ext. If a
regression guard for this is worth having I will post it separately; if
not, the archive link is enough and I will leave it alone.

Either way, the reproducer turned out to have a bug of its own, which
the CI review found on the same posting: an untagged task pinned to the
target CPU starved in the shared DSQ, because the target CPU stops
consuming that DSQ while it is holding something and no other CPU may
take a task pinned there. With two tagged tasks handing off it could sit
until the watchdog unloaded the scheduler, which contradicts the "the
machine stays usable" claim in the commit message. Dispatching anything
with nr_cpus_allowed == 1 to its local DSQ fixes it. Noting it here in
case someone takes the thing out of the archive.

Thanks for the quick look.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
