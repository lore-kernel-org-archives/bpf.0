Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8612F5A7
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558089; cv=none; b=eM4sdxEGYbGMqF1LmAKjJezU0NXgecQ+5nmHqTe8lShF5/5VzjKENrDozeMUX0Am0kS3hNxoYPSYc/3bZxnqKgC11ms0O6NzbEQQcHcOZWGSq9/xB0fUjBkgJDwVbFQOMNvsahMF+EjPqHSb+WZHYOcv/LsLfRi34NpmKJCK0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558089; c=relaxed/simple;
	bh=STWdLaU7NsiieDzWxE4MlwDhslDAJ5TloruTp1fV6W4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=btcUVQoFJNS6NjIJXZUOslXmdSf12UMnQYTlxhASglgvUTW6r6UchkND4ECMw4JWGwW8MNXdqNV5wfHkabWpxnjvkxZRuvPYt0mr7ZDOuR/whA+pzqjm+HYENEYml/zRBONRPkrUUnigZdYZ/R9FFFcYA9G59IpcvXAx4dwFbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnmjR2/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnmjR2/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2220C433C7;
	Wed, 27 Mar 2024 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558089;
	bh=STWdLaU7NsiieDzWxE4MlwDhslDAJ5TloruTp1fV6W4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=tnmjR2/KnH0tqeweCjrf3p+XRRIdORbJy7q8RW7C+jR03w+HqaGhIvyEhBUgLTd1b
	 JLfg1oFCOJTAN2Li6EIkPafQwBbDwa6iJhF+W1Hs6Th3Wt6n/nfKYAO1yELA1uBMWM
	 KJhzmXMWouEYBYuzSz6a+eyvzEPvWaZArsDdpTFdCKP59u+9VRtwTYL8JmsTyssAjk
	 f29SztmmRONmHqJMWDE6BPeXuhzuHNOhrLXH0vGc0Hzjui+WVOJv1dm5Ll6Frx6N9H
	 5IACdBlLnnZ44Pxzsl/3WT6e9Mb2grOhWUsQfI4Mw8LftP0sYmkhhbhbw1mKvR4pCW
	 yqrpt92MBc+qw==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH bpf] bpf: update BPF LSM designated reviewer list
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <ZgMhWF_egdYF8t4D@google.com>
Date: Wed, 27 Mar 2024 17:48:05 +0100
Cc: bpf@vger.kernel.org,
 ast@kernel.org,
 andrii@kernel.org,
 revest@chromium.org,
 jackmanb@chromium.org,
 daniel@iogearbox.net
Content-Transfer-Encoding: 7bit
Message-Id: <1AA4DC87-5BBB-427E-BABD-263B00FAF1D4@kernel.org>
References: <ZgMhWF_egdYF8t4D@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 26 Mar 2024, at 20:50, Matt Bobrowski <mattbobrowski@google.com> wrote:
> 
> Adding myself in place of both Brendan and Florent as both have since
> moved on from working on the BPF LSM and will no longer be devoting
> their time to maintaining the BPF LSM.
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: KP Singh <kpsingh@kernel.org <mailto:kpsingh@kernel.org>>
