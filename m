Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB363B9;
	Thu, 16 Jul 2026 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164305; cv=none; b=In0J1EGB6/TYsMSz9biKP22XkZJsvhoMrIdhJSipMzbttRiJBQywX+gdkrBMJgQSnNlzQ0yc5r7rZ/B9PHvuBid/MZr/2mpmsvFQGaMRBrmZenYukV+EUOa+HvZQB2mqcBHjax7NyYjtEGo8njkxAj0W+YyHXxSHWCC/G5d9oP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164305; c=relaxed/simple;
	bh=HYL3qr1ErMj4T3xZbTN/PhA0hBrW4bNeW8p5F2LugtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGsgYd7T0yX6CT4leckwyRP8zWBaLKrzIBYQZuR6CjOliqLXeDnqHbKUzOmyQI6ngQio1J1OM6BHe1C1RwO/hWGv98Fh7uYiqF2ludB4jlJv+Pe93o+qYPkXObKF9JrMb6+RIW3hoqm/mKbTuxtk2E40PU4/CyMav2zMO3TJ3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clyzT07b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clyzT07b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F4F1F000E9;
	Thu, 16 Jul 2026 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784164304;
	bh=/JsAvehaTW7XgYDPnlHrGydiJWpXen5k+wZcuy2ARqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clyzT07bdvS+n/PX7T96wFYjzbwqxsEE7E9xBi7D92DreiMjs0MaOByX8LSxY98w6
	 bjqURRF6BOuGlOeVWz9wVYz5+Zf8Y01zpwsCtob1u1jnHshkJ5xWCljtV0dteZaWlO
	 t2C9KgpHDvjLvgGTUqLfcTETcuJ4DiICfJYUXc4N6b5BvlAScK7M8sG3fzRSkS1hjB
	 z3U5jAULTtAdZbFPXmS69PS21fDZKpoqwdda6HPc/dbnuL02wkS0MLhDfurppiaK0n
	 ratCng6CkoxOkKD50MpBRyJE5Ch7eP6mzB01Rc6+TyUHRDnv7AqYEulV7o6Pb7srmc
	 u3UkmAn4ubSvA==
From: Kees Cook <kees@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kuan-Ying Lee <kuan-ying.lee@canonical.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Fix pointer type mismatch build error
Date: Wed, 15 Jul 2026 18:11:41 -0700
Message-Id: <178416429755.1788203.2869107770233893151.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715053559.28535-1-kuan-ying.lee@canonical.com>
References: <20260715053559.28535-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Jul 2026 13:35:52 +0800, Kuan-Ying Lee wrote:
> We hit the following build error while running the seccomp selftests in
> our testing.
> 
> CC seccomp_bpf
> seccomp_bpf.c: In function ‘UPROBE_setup’:
> seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional expression [-Wincompatible-pointer-types]
> 5175 | offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> | ^
> seccomp_bpf.c:5175:57: note: first expression has type ‘int (*)(void)’
> 5175 | offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> | ^~~~~~~~~~~~~~~~
> seccomp_bpf.c:5175:76: note: second expression has type ‘int (__attribute__((nocf_check)) *)(void)’
> 5175 | offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> | ^~~~~~~~~~~~~
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] selftests/seccomp: Fix pointer type mismatch build error
      https://git.kernel.org/kees/c/3421b9b056a6

Take care,

-- 
Kees Cook

