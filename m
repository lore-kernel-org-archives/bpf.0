Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A13FB84
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935178; cv=none; b=pW2dWlCzHrMOE33YVNf8MMPPOkNoaV8HXrgHcMBwRaK9ti4mk0+eTbwIkRLmvGqq21lCv63RY9huiaMnvF5H+YI/0zqJOQldrXnp5CHQjM89GfDCc/Q1uN3JqrAsdr3q/5Z/j2vK/dpuAMkDY4cExGzN/6rjXx8RP4pYaOVuI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935178; c=relaxed/simple;
	bh=xvxYvvj2PrGZPik1dyr7SNwMcmSA/MFYDySIST/v0SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq8Vv422DjEDX4SOLBTlqVZE5vdYJU9G7X4kfugVaJQeTDLNwuOkRLX8tLIfDI+5QGsbCGrNGLB/7DuVpPdnLcleJnI3SdabpTlb7n8idq8hzqIGhs1baFM6wRqpKQjeR2q5b50Mke9sBg4FxEYZ82k6nGeDW72RjfdXcnCUKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d4c0jQlX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d4c0jQlX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ddd1624beso490717f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710935174; x=1711539974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvxYvvj2PrGZPik1dyr7SNwMcmSA/MFYDySIST/v0SY=;
        b=d4c0jQlXdAchYQcvianWbp5w1Um+4oUj6Gnzr5s+NBCMjAZmt1AOcL/gzOc+lD25Pj
         5yPResWvfb+BNdd4B3KywE7HiUVd1tZz9DPsApGGKrE3BL3UKz7SbRehmxaK4aaWh/oO
         Ldvd+XsnYuopLsZHP0tOnrBildha9vxNkwqvppe0UfKpoiBI9vrn17iSw1fLhlhsug0v
         YHLvtsWXg6JhiSsWJfzNHtqnjLGgFmc3X6VpS0JFRNeCp++6etkQfxbxkqvmtkYZwJxg
         9IVkwiDCMUCAaVPYxvFkoWgpUWhYvQZ7ymTPhBwIc5wvTBzYu/mqT87L0akm/RhGjAY5
         EfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710935174; x=1711539974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvxYvvj2PrGZPik1dyr7SNwMcmSA/MFYDySIST/v0SY=;
        b=mBBsj9dnrWac+CLyIQsxD1mubNHLW4trXh9d3PU5Z3BQUuhSScI0I06D6GCJqsoEnT
         I05hmdQZfJgMd6uGFHH3HJdww33DXRb9KULKKsmGE4cBUXrmdB3g6bmvjNrLkeOV6e6m
         EM6ndTOjsPrhqj0JFOXqwFVG6O+hEWpWWS6scTQ8B7/+ZqMJ4ON6phUGP9B/o65bRsLC
         AYOB9Rww8YYRJQjtWtKOJZxYvpJ9mGKtcoPmJ6FDWcW7BpJaQdVTDZD9ChcOwv/7lyPL
         NhRQ2o8ORlry05AMf2oOaKH1OuYK3hb0W4rmSqn4XYAZ6LXS/rj8+bXbk5qkil7G86T4
         Luxw==
X-Gm-Message-State: AOJu0Yzq4gUJpyEaV04Z6r96Qnzfdd19LAAilsKVf5F8vXgVB+OT8Nu5
	Rz2HMukF4fNsbzw1eCO1hdpCvzV1XNB4eeMBq6/7cEdIr6W6ZevdOW/9oDdeLFU=
X-Google-Smtp-Source: AGHT+IEvyp+DHt43dAosLH0xu/t+KEeQu4t7loU2bJe+oB1ozYbyXGl94zR1LOfuWazWeC8n7oWbEA==
X-Received: by 2002:adf:ef02:0:b0:33e:c595:fec9 with SMTP id e2-20020adfef02000000b0033ec595fec9mr4921514wro.8.1710935174599;
        Wed, 20 Mar 2024 04:46:14 -0700 (PDT)
Received: from u94a (39-14-2-206.adsl.fetnet.net. [39.14.2.206])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090aaa8e00b0029becfcb97esm1352592pjq.22.2024.03.20.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:46:14 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:46:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Paul Chaignon <paul@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>, Santosh Nagarakatte <sn349@cs.rutgers.edu>, 
	Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
Message-ID: <ja4tftcecd2ozyn55333vi52ixcwxlvk4tc7qbrqb4k56fy54g@okqt4dnxantj>
References: <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>

On Tue, Mar 19, 2024 at 09:16:25PM +0000, Harishankar Vishwanathan wrote:
> We wanted to give you an update on our recent results with verifying the
> soundness of the latest patches (Re: "BPF register bounds logic and testing
> improvements”) to the eBPF verifier’s range analysis using our tool Agni [1].
> Specifically, we checked the range analysis in the functions
> adjust_scalar_min_max_vals and descendants (for arithmetic and logic
> instructions) and reg_set_min_max and descendants (for branching instructions).
> We were able to confirm that the range analyses in kernel 6.8 is sound, with the

Thank you all for working on Agni, and the continue effort to verify the
latest codebase!

> following assumptions: we only consider parts of the verifier concerned with
> range analysis (that is, the part that updates u/smin, u/smax, and tnums in
> bpf_reg_state), we only consider scalar types (SCALAR_VALUE) in bpf registers,
> we assume Agni's translation of the verifier's C code to logic (SMT) is correct.

Q: looking at README in Agni's repo both the 64-bit and 32-bit u/smin
u/smax gets verified, is that right?

> ...
