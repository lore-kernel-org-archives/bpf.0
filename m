Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735412E7BB4
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321500; cv=none; b=WDNtbMuON/ycVIFzuK50dHVWq0ggebGdwrTC3j9R7b7dI2LUQyR1TN2/Pfe6+6fmTvp7yIOmCJvzIyuo9irwWyzT2KIXBZc1vv/8ZJdVd9rA/wNmbGJ/P33y2/Hpg7JQy7tdc+RzRIAfdOE/8sXI36Bbjh6mqXXTTcmjCS+beJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321500; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=DLEi6LyTW4Pbjme6E1UXt7ITWWghov7enFB8/XpcNJO8J26anpkKNjsRDie0DWZqwoQA3RGJ0debYOvRUb5R3kRDs4gr6XFUHu0EUmgcTwwdCcBNiLPVGf/BDU/VSD/ueel8NvAnJ9ZP0S0PKCuUFxdO3eNtwNsvj0vJYq4mFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pebblebed.com; spf=fail smtp.mailfrom=pebblebed.com; dkim=pass (2048-bit key) header.d=pebblebed-com.20230601.gappssmtp.com header.i=@pebblebed-com.20230601.gappssmtp.com header.b=o1ihuX2t; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pebblebed.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pebblebed.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pebblebed-com.20230601.gappssmtp.com header.i=@pebblebed-com.20230601.gappssmtp.com header.b="o1ihuX2t"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1389943eec.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pebblebed-com.20230601.gappssmtp.com; s=20230601; t=1770321499; x=1770926299; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=o1ihuX2thbeVWvin0tvvLurooPKERnbWRwJMuv+ASY5S83EQmZ2vU1bUH0MJ5Me8Kw
         1pwSmNtR9AArKZ14/egtdHTRkLtY14V3Wf+k6nd8bhb/d9cDfJm4gZYG+/Lm+jKuanYn
         KVIt8+QY7i9Y1xePW0LJ544hWXYD6q1q1xyN6DKN3Z8tvpWMaRe7YKdZBjH22vtwtXwa
         //Ul2QWUek2kSQ3mPsoW22pZFQpwgBzcGRSCJhVJU9nizbc6Hw1YqEihBXyFH7dXPzV+
         2K+av0zJW167LqqXKVMzUBZV5LFKAOzH1OxgQ1IT/9Z0xvZPRgaRfuWCxrT8GdsMObsA
         vW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770321499; x=1770926299;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=O7zhFvzKKOXjKUXj9O0qBDvcAv7b2CyKDCddFpJU7Cp9JmpoRqGeRLWNc+pbNFZqd5
         WWZJ2Ts0HSpEU8rAhEJ5n2akvlGZ2YjqKK5alMO8ef5Qp4Ns8etBBgX6CiuZPbdLEDrW
         YJLgJef6iwF03hFxJwl+RSm9uzRYfsG84/OS6zoi384vqVu6ifBVL4O3jZRvv35W04fV
         +MALUfCan3m1A2/+dMCTLftyGP16zmzwBhaYWhqWUBQts5/8XwXyNVM6dvpHcOtdWJhJ
         q/7W5dLAnDupdhThdlx9fEo6LsPavX48Xe9/HlC8vX4DEKn7MFHRmd1fF0j+vfi+w9KP
         GB7A==
X-Gm-Message-State: AOJu0Yyxsj4CtsKY4+9oWK8g31fBHHIBmWzSaMU4qaKyTcHlA+ZtYMCk
	Dx//lhsiac+Pv+8IoNqHyCraRsz1gN2kk9LDlURO25M02Oza+GNfG6aNITdJCE2qgRWd1y1R+WD
	KAVoJCtI=
X-Gm-Gg: AZuq6aKvyMBpnID9R7m6L64XLJW4rl4U/hvNOf8GnF2y/Y5ysqI7n+X9MibkK2ILpiZ
	fOL5yjRa7jNI76TiiT4+BDYns4tatEQvjGse2WvN/wsVflUTcZlClUwMccZCeTRPwH6aRv2du4+
	OmA5/D+B1LseasFDW43ZU4dl7Z1EbyvuI/7fdhm65fhTfliaEJ2Vgrsbg9OJeVtTQh6/shnUqTs
	fd+VthWWMTE5PIemRUG7VbMJ5w7iLqa9tdCYkDjnXbFXQMy4/tGEM3eyuDwHOJZGbjGCrM95gUt
	osctXJV07mup9zutc8bLPTT14+0chCbMxc71y53qLGSJGn0raR2InYgGMrNX/geXmFrXn4BxR1q
	qzchaGp6Lc4bRiRzDQgwBIGsNOzul0sh+PalfcWerYfgF5s2i8SBBeN2C8CIx/6SqVKSntXmK0y
	rFYhwwH9aTak3feWGTqM7MolpKOy3NjVYb2Uewwf51VlDlPTaUR2p5bnFqe8xeeqk9iJunlWG6U
	Fors+6Cn7SCXErrqIeiVmaWdRG4NQyF4geL5w==
X-Received: by 2002:a05:693c:3007:b0:2b8:30b8:58c0 with SMTP id 5a478bee46e88-2b8563d810cmr132717eec.6.1770321498860;
        Thu, 05 Feb 2026 11:58:18 -0800 (PST)
Received: from smtpclient.apple (fw1.pebblebed.edge.customer.sonic.net. [157.131.48.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c6a591sm235390eec.27.2026.02.05.11.58.18
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 11:58:18 -0800 (PST)
From: Jenny Qu <jenny@pebblebed.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: 
Message-Id: <9FD2484E-12CE-4F00-9D42-067879770D8F@pebblebed.com>
Date: Thu, 5 Feb 2026 11:58:05 -0800
To: bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

