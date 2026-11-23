Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442985;
	b=DGqXtbblZQxDHjgcljlrPlnGhmkA6WCLmMhUH+0pmt2h6b1whEmm0V/c6x/eATkZ7Mks
	 OKVYbhaNRLB+EUaoKNY11gOqPaOVtBqS5j45Rc59HvPXo/uc5YDlfP/yqw7gIrVkm9+hH
	 8reeqWD9rXgHs/G6YqMtzNVuHWfKtleI1iARwplU8IHCDKwzA/hcsPpjnAlCPR3q7QcLQ
	 2YO0JZfla45raw9cnh1DKiVGG77EYI+CnAmAqzaIWSBBtqbfqZ/zMP7EO0UCPiQOsUODJ
	 +RZQO/Uut5Io3N1kh76TR7yIcqJ7t5ZenHvXepqLRGfEf5j0u+zSfSDMRwWrzmoCT+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0bvDk5tyLJ5TwCATr3/cvszAQOWSZaHFXbKMbS8WnfE=;
	b=aYRx5km2c5HTzf2mbOxSfMaObpXKoRWbH/leDssw/LuucVZODKPE6WL2Q9CHxTcnQJFZ
	 kmLIki2NCe9hDLOQX2sQ18ZdZikCGhrNhspWAbY+U3x8vpeNBJWB1OCY1c3Xwxg0SFQo4
	 I1j9ZjjP/LlsZmlvc1psWt+aYoj/SEG3BFICOVX+UThNIz5COufy76dJafZfFdFx7Mvo4
	 0DKXzfP1sV4pior8aeOeRGSoSXVTBY44WWmxx4tVtDCGz2C9eHFRdaPH74fMDnpLkS6HJ
	 bLc+/bpvGMDcWsIFKjY3RUZ8k/9U6DEJtIgOw0tRP+79D7ku5QYGGIJu9Zp77YpCiZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=T2k610q9;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10FF606A327
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 14:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10FF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=T2k610q9
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so1542347a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795442983; x=1796047783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0bvDk5tyLJ5TwCATr3/cvszAQOWSZaHFXbKMbS8WnfE=;
        b=T2k610q9dq6ABxK10/kvUfovzJT448peNpB8dZUFJ7a9M95oiFWIkbejfgpR0jq3ps
         JmdtTO2qbdhrvAtfbsYXLVSDSj3iPLnoYA3AX20Nc6N5ilB23Ve496FNeGcV7q0NLeEH
         zwQuebg7Y6bLkIXAEUPHH+uSwfuw6ufCyUCvbhBU9NiUlyP57IAHmhxTFNak3+iNQoEP
         lOkgQOTDkr075zM9+0efVaR+ZKdXXN6K2z0jb78i2cdgl3LzuXCqes7vTBoEVLPtsHd8
         ZLjf3wMWaNh5pzx2RJwOE7G6lW3A4YPzGRKoRnnaO9HNICIVLd+xvK5jcsu4sWPpH5S5
         uetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442983; x=1796047783;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bvDk5tyLJ5TwCATr3/cvszAQOWSZaHFXbKMbS8WnfE=;
        b=YCxJu63lCixE5u7yeI37FcCnuOYlXSi0TXkQrfGb6qhCIyKM+EHar+pr6MIFrTUDK/
         K5Wq+RjYJYd1E7z0P/phKjtywrZPKBLUJhyFcMN7WMN0qj+CuWjVcDNpx0TaGAhaMJ4y
         JSoJ9FC1A6gszZK8T/47MwCr/JeSL/f38wM3lgspzFlpnBj2UWftKoM7YbDmcqFO2ULs
         cRM1xR8eZon5LgDWZc6CQpgvZAucvAzbtFoK0l1qogObXmd/inDv8koK9hrfcerYkJfv
         NPaBjy0dn+bwEjiQffHMIvRp+MuXpsvlgeBrqmDL1nt4blGytzbf612j4j85poqgBk9S
         BgTQ==
X-Forwarded-Encrypted: i=1; AL+hErEirTKO5RXLszpr9P+R9Ym7J0ryIoS+WUaQDwFnW9NMBcSdLT2WoO3Ch/HUj8ubIsQUwaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bW+obKV9R0BwTpcomKt2tOXJlMpVnvMuapZyuMcE0BqrdLzxH
	pzPX9SP+KfjscXOBKrmjlXpIlk/nOWin5Q1F+cOu7KHPKzZnU6y5Oyl6LgaZSgM98iA=
X-Gm-Gg: AZFdTZcBjGqdEjAKNDf4ZuqHSKh23fv+i+KCir0WSLpx+Vxph/z9nuYaPfXNmzNA4bm
	d3SPFA9OBSLb9/g3gFzecOHJVJrkCsmcJVJrWlMZUOIUIeUKgqQ6+L6zcueHc3ZvELYUToP+mUd
	rJjexbAgKDlwhqqC9+Shl8GD2C6csIBe/uf+kogYz3vv7Ek3o+3QB/cKwlT543B47eFBvdtYJRM
	kWh0bKVqLM5DoZjY+1AuPCXxFgfRil4mWCNl8K1GA3TNJfJJPAG3HrfC8PB6hI3ZTgg+HHJGxhe
	SktpN5lht3FRIVddH7RNTh9Eu7AVTg9vps937hSBWbnecjprHlpF6a2Dvoh6o1fA/VDrVKU/5Gc
	JY6Ax1oiFR8EEIrAi1gmNVlUuoI+JAokVDQIA5RiPSzkTkv3IZVu/qvqY19nIAJUcT3UcBWvK7g
	Z1Zzo3/G0V1SGfBfUnFjviQsPfrJWYWGeCwSCPI2s1gn2/eSITcjBdsOfrzHjpweOmakRAnNBzw
	+ADa6Ys4YyLkOOFhY3IoseDz6YkNx5kl5g/Qczcf3h7ElxLIrW2nYTa08lYbfmBJ0fR3P97RTaw
	m6BCOWSWUuTQ55jL3tDrC8QkcgU1XJRjww/oZuMQ24vLOTc=
X-Received: by 2002:a05:6402:3223:b0:6b6:e74d:407e with SMTP id 4fb4d7f45d1cf-6ba37eb9c1emr9126325a12.36.1795442983003;
        Mon, 23 Nov 2026 06:09:43 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36d730d1sm5419955a12.0.2026.11.23.06.09.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:09:42 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: hangbin.liu@linux.dev,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net-next v5 1/3] selftests: net: veth: derive invalid-tx test value from kernel max
Date: Mon, 23 Nov 2026 14:09:29 +0000
Message-ID: <20261123140928.13688-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121182217.4609-2-emmaonana18@gmail.com>
References: <20261121182217.4609-1-emmaonana18@gmail.com> <20261121182217.4609-2-emmaonana18@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Omokefe,

On Sat, 21 Nov 2026 19:22:15 +0100 Omokefe Emmanuel Onanaroghene wrote:
> -ip netns exec $NS_DST ethtool -L veth$DST tx $((CPUS + 1)) 2>/dev/null
> +MAX_TX=`ip netns exec $NS_DST ethtool -l veth$DST |\
> +	grep TX: | head -n 1 | awk '{print $2}'`
> +ip netns exec $NS_DST ethtool -L veth$DST tx $((MAX_TX + 1)) 2>/dev/null
>  chk_channels "setting invalid channels nr" $DST $CUR_RX $CUR_TX

I ran veth.sh from net-next on an arm64 VM with 2 CPUs, under
"taskset -c 0". Without this patch, this check reports
"fail rx:1:1 tx:1:2". With it, the check passes.

Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
Tested-by: Tianyi Gao <tianyi@cloudflare.com>

Cheers,
Tianyi
