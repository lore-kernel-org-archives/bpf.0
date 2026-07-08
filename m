Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15554388862
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497890; cv=none; b=NhpTcQmAnXgkEDt4W242JQy9b04Nc4s3nT3uA5+EfGNQ1a9kp3Wg1m2JA79uM01FpGHF7AMbFCNIC9E2CUzfQzt8T5lfjrX97R/7dcpsrWQJqKVe3gtHJ8bYjS3S2HvAiZZXEN3cB/5ONwsbgj7R3aZiYx6TkOa5lD/Bc7s3x8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497890; c=relaxed/simple;
	bh=lhKSffhkWzsZ0/8rfDC7YE2ivqQOUh/Jm8bDdf9qJW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvlUNgk2V6C/orcGfRQ4BSpAV/128Tl8pK7loIQfgLYgTHOS25edRSn+S5rcakhVxLNzwBGVVtVXfgQ1RPVVwAFRdCGPYWJX/34FFfSispuwMBycEo2vPe/re3i+zM0+xbvbThKW4g/YdovZmIvoBmj8PggCmv4x12N4b+YQ2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tESaesU1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tESaesU1"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9c80265bd7so225912a12.1
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783497885; x=1784102685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhKSffhkWzsZ0/8rfDC7YE2ivqQOUh/Jm8bDdf9qJW4=;
        b=tESaesU1raCpuNWf2JvAnEeXLHI8sUQcmt9PGuNv5NbzcwZYHvL6troiP83gF6gWI8
         NYcUj2N80mkAuGimeoTMcot4YlSmdqA/N3BFU9ofrgtB/fhL7J/uDmglEPxZhRzdWuYL
         dD9p/b+0lfeCjxAPW1AT5JEkQH1vz6xiKjxv7q+OuszVamrdoxraPLmEpV/MB+MAMK2g
         nilJV/I+veph0rnnV92UMTinF73W1/iObmDdTSH1dZJWQwUhjf+/9CssPM5pDC91+lNT
         XUhvu42LseRDdw8rw7xhxoTK9w4S7MNCPbmRPMt817MXLVUXDc0DfnkqsfeUnytQAq5k
         BMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497885; x=1784102685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhKSffhkWzsZ0/8rfDC7YE2ivqQOUh/Jm8bDdf9qJW4=;
        b=BpKd86YlfnM1UvD4VSAusIr1sUkpNll/UtR4aDyxrD+MW21P7i3fvDqSxb09Pxk5o/
         fLhKzWr2YMQ06/ftuADRS/Pu/seoeVEDnQ0J5aL8DcgEchcEivTFqZi8+eV7Gy9v10iu
         jKa23RX51gQumka6bArRgoVsnmjeeWSUzJKv2vIFc3GEfNWGf60nvKhwkzehjWZdo14Z
         2llxb6v2lPnR6J664FwNO2/EyY/+qR7x/Cf18rx+iZDCOwzER977u6stnw6JC3PdtdTK
         P6l78bOtmkEAQlvRYnvDw+bbhBUisUQuAs9nbFJrbN+EcD8zPegwwLl0rSYfkOzmoj7A
         4aJg==
X-Forwarded-Encrypted: i=1; AHgh+RqSI8+L35nzhA4BLmBJ8E+nbtr73tSMOwmByW8wzZi7mVHG6FIhT0aDp+dVQLXH7dtGlYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSYqI47RVkPorcwtOUQ2GZQEr2sJYBEa3kWOhzWDdLos19erC
	YHaTq4rN357um+S6mNln80+rkpY0yc/CuU2Y2Zp2OiST7lG+pM1MVQgw
X-Gm-Gg: AfdE7cmD8oszNcaJ/bxNtaa3rEQTww1FopI96LNzYPfDi1mdZLpcWl8sG4SG7LHxSKS
	BpWTNVB/A8hplg6cngvjoHD4V7/GNIWR0Vj2es8hWIvN5gTAl8AKnlcGMXShljvmYtiY+ZtVBcx
	uHUrbIsr+qPpz+xAkG1oWgf+rAsLhsLfuPyTZ68ft6k5QjmCX2l1wOpb93mpDMk2WQslnqVEgUB
	yAeFxzTvF6XFdi5gqH3Sxo25FcFMAiQ1YvugOwKdLPubwk6HX2077T6Sux7MBoM1zHxUGPIENPL
	dZLkwskZYNCKO/SG1miv1slnQ1VCIFfo2jf2jX4jE4wH5WqMUMorQFw0rkqKj3MprepdOMoj9cO
	6PHrPy4RPckY098w6+J2G/Iu2jzIeFm+MICG8zvGggfb0gntbZvaUvjikBLEQKwFjl7IxOj0q7u
	t6wHjzB6qcuzmYGsFpx4NHWQh8AQocPHP+95+dzlsG6CHwW5RD198daNcrmaw/
X-Received: by 2002:a05:6a20:1587:b0:3b2:86cb:929e with SMTP id adf61e73a8af0-3c0bd206b59mr1755177637.46.1783497885553;
        Wed, 08 Jul 2026 01:04:45 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm2220581eec.8.2026.07.08.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:04:45 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: toke@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	eyal.birger@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rongtao@cestc.cn,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yatsenko@meta.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Wed,  8 Jul 2026 13:34:34 +0530
Message-ID: <20260708080434.732503-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704092159.1256823-2-avinash.duduskar@gmail.com>
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com> <20260704092159.1256823-2-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf ci bot flagged the VLAN_FAILURE re-issue advice in the uapi doc
here, and the finding is real. By the time the lookup fails,
params->tbid is gone (the h_vlan fields it shares storage with are
zeroed on entry to bpf_fib_set_fwd_params()) and params->mark is gone
on the resolved-neighbour path (overwritten by the smac output). A
program that follows the advice with the same struct and DIRECT|TBID or
MARK set runs the second lookup with a zero tbid or a garbage mark. The
selftests did not catch it because every arm re-initializes params,
which is the safe pattern.

Toke, the re-issue recovery came from
https://lore.kernel.org/all/87jyrwf9g1.fsf@toke.dk/, so before I
respin: my preference is to keep the mechanics and fix the sentence,
"repeat the lookup without the flag, re-initializing *params* first;
output fields overwrite the inputs they share storage with".
Overwriting inputs on the way out is the helper's existing behaviour on
every path (rt_metric lands on top of tos/flowinfo even on NO_NEIGH),
so one rule, re-initialize before any reuse, seems better than making
VLAN_FAILURE the only return code that preserves inputs. If you would
rather VLAN_FAILURE restore tbid and mark the way it already restores
ifindex, or lose the advice sentence entirely, I will do that instead.

Avi
