Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059952;
	b=Fm9cP3uT5wazMLETDH+u6eu63q4Oxuq76Kz87IivdQdlKHrPlacvsEp9krfFMvAkWqju
	 DYqCit1cC3MgJvEXhVXCYNaH/GgvETrBULjr6t4sLsFiazenGbrFMMv0dGACPLcQ7rqGr
	 k1OqBLfWcn1BK9jBrcNaiL3Fe1Cu2NIehcJtNnO71vIrU716pocsX11PCCc2Y6iDnhnm1
	 tvralBAN4MRoWCF+0QPSlpzDYoSUx6OjQ5Xl38wnDh9umEdWnUhcuut+qaKlC02rHf2F4
	 Nmm937bwW+ifqJ0N+GI+lS2HQMajfu9Db5Xp/59WXKKVo2hAM1VXaMT5Kbhv1qX0yTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=8qLgOCLTulYn1+d3HKH9PJ+ODujlzAUfUScnoc6M1Q4=;
	b=qgBbz41S8K4KXrjyihTfVDY1Q4UxijrErSb+EY2vyKDeulXbNW67P6c2d4u5VyBBqs0i
	 sPZgZIw0AvlxSAgt++MNRIc/rpEM8Jh2DQ4HPOkurothzK95Tydkskze9mSc2DxBXOF7/
	 jX33whsLMd2oT7dKV+DvD/RqMF4zxHFeJ+g569wbKd/TbBV+VTY2v44dHjuV18yT286pm
	 7/dnW6jPieIyQUH5u7D/mDkssZE4O4OCg27gIxmAwadouTj0DL+0p8AYVi8Va6YVNCX00
	 yADst9fN531pFpLFPNIhugWcO+S0j6LlkTpRWK6DaYVNbtPxIJqAYfOXC/DpXtqHZlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbOzaWcX;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D5606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C4D5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbOzaWcX
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a07078200fso979809b3a.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 19:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059951; x=1795664751; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qLgOCLTulYn1+d3HKH9PJ+ODujlzAUfUScnoc6M1Q4=;
        b=cbOzaWcXbcVheE/8dJiWdbmV7ND1PTau00PwNAkfFFOgzBe0y3gTkUsXRdkoVIeOHO
         VrcxSXC5ebaT4qrKtimClxvPuslbSxyhKy9GASjTFGTFu2dcelOi9xyVsdBxAc/hzED5
         oRhUxwnUbIIzsswiB/TLHTAPyWXMvfL73E0GTCffu3VCxY9XbaDiaVpf2YbrHmH7mU+y
         gu8nfT1P4y4gqTAUKJYFBhyh+rnujd43p134tcyfWD+xBMAY7N8eXQofxNUtsVcE0Ev6
         fWN/ptHi/ZQ5Zgeq9h2Uk73ZFPdC1iZ4gXD+RZQh8QAxb8WNd/rV60t3Gpci0oklxgKB
         ivZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059951; x=1795664751;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qLgOCLTulYn1+d3HKH9PJ+ODujlzAUfUScnoc6M1Q4=;
        b=2n4SxThMSEsmSKwxwFp2PDvtVQKNurVy+WE9xxpscgPCmN/mRBc1OPejzjoB5zKwNo
         sKCRi2s4VZaV0BoHv5G+mMNkpmpF3opbc6sfaxJDaChJPPYp9tWMsw3F/OVUBTo4b3Ph
         UZUhdY3c99zVbjYTNk6rG4nVPRouIzMtLF6NtEeHql93YqAaqyn4iyXv+lCTLPn87bSb
         IufdhKfuvKPEYRbNotruzxCb4RaT6zqjZ+/5rRy2zt0sUqdW2+1fY0EKycqdvx0ZJX8W
         CiuHFUG/GX1o/fFiywI72jXMeaO/1XWobwb1eeszWmb/VnQF3kTpewmZ1LN3UO2+SHDX
         i6HA==
X-Forwarded-Encrypted: i=1; AL+hErFcJJbI8JoDhr6qhwa9KhGgHggTHnX+OgYH/OXSTqlICK9BYfL0jOlO/8L7vVmLAeWK6UY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FQvuqZUrLjrIX/fXnx8zL0pQELKDNiV65hZEtwMl3LTkiO/dE
	83scxeGdvLr4bwxfNxau5gLJsikA6KnexuVcvr0xLBFtniTb67j5KNaK
X-Gm-Gg: AYBFou0SwsMzDA39QgIVAeQNInzyNSegamTI9D922LRCwS9sIF2rPNJ21nF+1utLsIN
	+0UyT9BHusD1oPlXvAHGtyR1OPawMQ4LVFYuT4HWDUlqiTzes/JDn3uLOtiW97tMyMUN4ApWq0Y
	9Uj14keT9nj3JwRwCYLnVnR5xQrKCdbKDEOABL2jfFMjAQ3/gv0b0r0EZ0thIttmmSdF4rbzUjb
	T4PjGM7ZuEzRV1hk+6R9ay6hGc9r86pGTev4mTwu3m4lXdpvFJgPzMLqmeVhyvLc3HeWoWNUoMg
	KcbA+/rlcRRbPnxvlsKRL4evEZW/R2Ov0Jtpq2HyfKiTkfv85sLwl5Lsi1+WRSnW5iFZhyRnDrD
	AYfbZDQu+S/EdgO5xk8mF3U/lrvRKYo/9diA+lzndnXguAWbstdeaPQUphFfB6w4+0YfD8x/mc5
	Bl6L8lyqPzigE7TR22jnk69VER7hmTsPEOoeDaXCJKan2ggsybnXqt6aNxJa7S6InlvYcMRNGm5
	nBo0vIyRgHQ8VPSQwZVTE9xbxWczUD4ZTjnS6Ch6q4oXunJsTM0ugmhvNYLvCaNZbDv8sf0kn5c
	KoTEtk9m26dO5TUt9MvbRQqvaYFflAMHfjxXMJGeskcCmA0wPnyZ7g/So9Q4EjYxmWzGfIbPLVL
	TQ75lSkVspvqP6LydCa4uOImyYT58Va2bz3MU
X-Received: by 2002:a05:6a21:2d43:b0:3eb:99a9:d3a8 with SMTP id adf61e73a8af0-3fe8b6e4faamr4692271637.64.1795059951330;
        Wed, 18 Nov 2026 19:45:51 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca5bf959sm2028068b3a.20.2026.11.18.19.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 19:45:50 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 03:45:50 +0000
Message-Id: <DMYVN8WPV380.3ID1QHDI7BKUS@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Barry Song" <baohua@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fall back when
 memcg_proactive_reclaim data lands in shmem
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Kurt Lin" <lylin1023@gmail.com>, "Hui
 Zhu" <zhuhui@kylinos.cn>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 <bpf@vger.kernel.org>
In-Reply-To: <79797479-029f-4e9b-8076-6a92a2a70cdd@linux.dev>
References: <20261117170704.1146730-1-lylin1023@gmail.com> <DMY136RTAL9Q.2WQSZ57W1YLV2@gmail.com> <79797479-029f-4e9b-8076-6a92a2a70cdd@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 07:04 PM Hui Zhu <hui.zhu@linux.dev> wrote:
> What about two things: only check when the test fails, and check
> KPF_SWAPBACKED instead of f_type?

It's still overkill. 50 lines instead of one more compare per test.
It doesn't cover arena_memcg. The failure there is a dead child,
and its O_TMPFILE is gone.

> 1. Check only when the test fails.
> What the test needs is "these pages are reclaimable", not "these pages
> are not shmem": with swap available shmem reclaims fine, and then
> reclaimed == 0 is a real regression that must not be skipped. So probe on
> the failure path only -- nothing is paid when the test passes, there is
> no polling, and a regression cannot be masked.

It can. Kurt's guest has no swap, and /tmp is overlayfs over tmpfs.
Make bpf_proactive_reclaim() return 0 there:

  skel->bss->reclaimed      0
  si.totalswap              0
  file_is_shmem(data_fd)    1    -> test__skip()

With the f_type check workload_dir() moves on to "." and the test
fails as it should.

Swap alone is not enough either. The prog passes swappiness -1.
With vm.swappiness == 0 get_scan_count() doesn't scan shmem:

	if (cgroup_reclaim(sc) && !swappiness) {
		scan_balance = SCAN_FILE;

So reclaimed == 0 with swap on is not always a regression.

> 2. Probe with KPF_SWAPBACKED.
> f_type is a blacklist, so the next stacking filesystem repeats this.
> shmem-ness is a property of the pages rather than of the mount, so ask
> the pages: /proc/self/pagemap for VA -> PFN, /proc/kpageflags for
> PFN -> flags, then test bit 14.

Bit 14 doesn't replace f_type. ramfs pages are unevictable and not
swapbacked. file_is_shmem() returns 0 and the test fails.
Let's deal with the next stacking fs when somebody hits it.
