Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB3556BB3;
	Wed,  9 Sep 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959937; cv=none; b=q1TZK26pv+S9DLhVwP7vCHYcGarmO09y53BYcgwCfsW7Pxa3Rc6UPwp31jPVJcDr1SEK3iuLy0GW21eVXfe8HLAM7RW7wGX5RJ1aYirMBTD3a+lLaP7s+Qa0B6e0EoBP9fgy/u/1Kgl8hXOGSmZAnFVN3shiIVdqla1wn+vjUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959937; c=relaxed/simple;
	bh=7//WCo8q7JlyL1h7Jci5kN133upzA3JPxYPsY7CB1OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kinTlqmwOWaS6rnSv3/glPHPkAhVJejleO7yi3kZtHenfjkVWAoN8pR7YQjlR9eGQx6C0fXNHxUMrKMmpYT0JYoyan0091Umx4B/FIFqdklmpyyysTHvh26yX6EGBz3jR9vS3Koia9u91o0gWqBJqheKCTgBiJ3HJt651RJDErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MV5Tcdc+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MV5Tcdc+"
Received: from localhost.localdomain (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id B7DD220B7128;
	Wed,  9 Sep 2026 06:17:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7DD220B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788959894;
	bh=7//WCo8q7JlyL1h7Jci5kN133upzA3JPxYPsY7CB1OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MV5Tcdc+5rCCFHR5ckx9IJxg+CiGx2oUC3RgrK6Cnwedp0AaTjHMm4sYbTA90C2Rs
	 bN8kHuamOYJhZJ5uKf7swD3tNwlfNvnoOZkqr3jXWkL3OnODWBwZNldx1n7OURtVZv
	 fRDvEIt1DidaC5g0iiuTydE4Kjc+vqmsoY6kD/qg=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: emil@etsalapatis.com
Cc: AutonomousCodeSecurity@microsoft.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	cenzhang@linux.microsoft.com,
	daniel@iogearbox.net,
	davem@davemloft.net,
	dlebrun@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	m.xhonneux@gmail.com,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	song@kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf] bpf: Fix non-linear SRH access in bpf_update_srh_state()
Date: Wed,  9 Sep 2026 09:18:02 -0400
Message-ID: <20260909131803.51861-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CABFh=a5iLOEJdPhoaWUhLc0eEqAuhnd83_jJr9MVZZG6gSJAEw@mail.gmail.com>
References: <CABFh=a5iLOEJdPhoaWUhLc0eEqAuhnd83_jJr9MVZZG6gSJAEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, I'll make this change in v2 shortly.
