Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A3457E78
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728996; cv=none; b=S+VLQGkR+r1/TVKY1r6MvOYQU7ByTNyZ2M26jZ21l/QrF7HvWvthVfzcRNeaI+QPuDHrUayn2I/QnsaubmpFpiPzOquHg5kR9nqHrE7P6/tqIopuwfNI/0+TQtEw4TWql38VbbEesQmmhqd0jiavY7Ihi6rZ0dhEJ23kzm2Yd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728996; c=relaxed/simple;
	bh=lHZ4J0AAeMNX/nJymjWhRsTfWDaAs7AW8vIoxrjNByE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=USya6D14+aazCayG6SfW3ZfB41nP9AAkslJVGo/5hdSW5pQizdowvVsUmp+pjLGKU98aY633FbYhm7kxpJkvxvDSdXJTqyEnhNmCXxf3OJGiTyMP8KHUkcbbEbeAtBmDrjywzrUYZN8TE/TAK3PDuZwaXP8+ZtlSWU9+GzDDceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMb9c7XQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMb9c7XQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e836252e1dso9135065ad.3
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791728995; x=1792333795; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=spNkyy0SDHZKmf7Xc6j19NdGyS2zYykBSQlRjeJAYNE=;
        b=NMb9c7XQvT5kXdS0FHaNsOpQF9JUa24el0lDSwtpsoDC6Kv4CyDTfF/DRMztBgL6Jz
         f8Up+Yqs8ZDWT7FVUUZZXNYmNKJ9bedBkMQvWRuNlrjMeMQWG5VhDyDUAwGyg+6deSZ7
         DUVq8WbgIRYE5YNwcsFvjO/FUIFv59u+ZX31E2zJg89RoUjsWhHIB/PFCfPN66pDLKWl
         O1mr1I0RU0k3Pigdo8Nm0ePlnfHva17GjITfARj0sRmS2jYn630rmJ1bwom0T1vMM+IZ
         PHdALtC6C4MKSvt8Q3rTqWVaPkd3hUgjK2+x21TjyGstAk/odIN1hr4jVmWtLH75vHv3
         Nprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791728995; x=1792333795;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=spNkyy0SDHZKmf7Xc6j19NdGyS2zYykBSQlRjeJAYNE=;
        b=ko5z50SAQTmK1Vknu+mJULjTEwBwKGxIPn5YB2k8I92TtE2qcdqPi6/+zQ30gfAEEb
         Ae5oOri5weEK5kXDVFpV/UV+fgxW4njXfKznW91gfUcpKo8I6SIcXMPslwhQA3k9ZBYH
         Jku6l38sk2GQt/xEk1+3lxBDpeXnxeGGC12Te8QXJp2kiQsRfhGmzR5LukG52eBba6yw
         5zog7j/gjitmAGuear031sZnnwBA+37eHGPG1oKZzQvd3mpz6S6gzjG8aaRedm0swEeq
         lH5d+Z06dqyQjVlAYpqMkfx6wXcnNkSVVWc9tMQVsQ968aAnLAMxDGcLqvBZHHNWeBY6
         Wwiw==
X-Forwarded-Encrypted: i=1; AKwUvByIiwDRtJDR+1JoUF38HNY8N2aHRhCLtxG0NGtz5nTtaavHNOxItDIO7Pi3v35psHrlLiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnCbryUR1XOlsqh4K58NjZ06zwK5g/48O/2FpctY820wUQsd76
	67vI3TJ6llQBv4vYLxYKjqHKHPGulU5kd+1PPJ/1ANpTSVSx45ovY6sQ
X-Gm-Gg: AYBFou2LBEWShCFyC+/oYgV39IzYHhv6/RezHibDkrZRLkDROH8WkYIRfelGmvHZXWs
	scQGua/5DzwJbPbEPHwtcwknU1KvTKqZGrODzG7T0z9lHfeiB1Jo4kZ1a03S5BjnjM0dmSKfu4z
	s5/EbtvEJhhDgzDal06LOXWksWjM7iUjAXFa02LgOrP4yQOeIl+NKZ/YhObuyz10S9Ienp1us7j
	jEisi/ODZsotqGGNDTjtOM1n6fLpwRcCzEJXlHMPSVpctYLw471+dw5uK1NUUlT22zX/FK6OykR
	vuvIalV8WOR8rUBAc/WaFd4JCr10wOAAK+qbyOg9WCokkbdT5k86rFEoaT64+SN58OI5jmR0Db0
	MiDf/mDEU6AcxezidGjjjCha23zFBWEPg9VB6o1SfblUuTUkoPpvYynkp84G+wlkDd6pnw7FzRI
	E/d6TGEyOIuVhmcgJfp1dWp/swvk3DzG9lEmrRJbEqj8nPMFGzyPA6/0HOYtD3sqJXD5ZXdy7IL
	4cv6fZ6sVnz1MeyTt0HV8LmnuxUgD6/bGMfpfWlgN0Tt9bt1k1qHLsySerjlN4WwQzQTYnyZL9T
	Kp6Mv7a530lbt+k=
X-Received: by 2002:a17:90b:4acc:b0:3aa:6b5d:a02e with SMTP id 98e67ed59e1d1-3ab3ac91dcfmr6500526a91.54.1791728994872;
        Sun, 11 Oct 2026 07:29:54 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm12551612a91.0.2026.10.11.07.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 07:29:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 14:29:53 +0000
Message-Id: <DM22X4LJYTQ9.1LK8R0L1FENWN@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <jolsa@kernel.org>
Cc: <ihor.solodrai@linux.dev>, <yonghong.song@linux.dev>, <song@kernel.org>,
 <qmo@kernel.org>, <martin.lau@linux.dev>, <memxor@gmail.com>,
 <emil@etsalapatis.com>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
 <tj@kernel.org>, <kees@kernel.org>, <nathan@kernel.org>, <arnd@arndb.de>,
 <puranjay@kernel.org>, <yatsenko@meta.com>, <atenart@kernel.org>,
 <ojeda@kernel.org>, <linux-modules@vger.kernel.org>,
 <arnaldo.melo@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 6/7] selftests/bpf: Test BTF sysfs inline
 representations
In-Reply-To: <20261009112324.1442319-7-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com> <20261009112324.1442319-7-alan.maguire@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 12:23 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> +		if (stat(inline_path, &st)) {
> +			err = errno;
> +			if (err != ENOENT)
> +				ASSERT_OK(err, "stat_inline_btf");
> +			btf__free(module_btf);
> +			continue;
> +		}

CONFIG_DEBUG_INFO_BTF_INLINE is not in selftests/bpf/config, so in CI
every iteration ends here and btf_inline from patch 7 is skipped.
CI is green without running any of the new code.
Pls add the config.
CI builds pahole from master, so 'inline' has to be there too.
