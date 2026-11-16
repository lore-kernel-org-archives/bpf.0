Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837903;
	b=Yhmm0oSOdxWSB/wvC/M3iy5WtQW1t6GKtdxGXOJgVI559g1Qjh2SFjmIl4fCvJtx+m58
	 Gu1wILTJ9ofkFuzwRVlJJJiRmi/cJji3zDFubnK4wqXWhvjgIJlKvvZBboy2EuDlNCHTk
	 C7tTmBsXld8M+06iXBxv6nAAnZFOVwyrzQLKXY0iFb/Vd22i2rvHN3MrWhvt4WrmGfvf9
	 O4VhN4uROeqZJLfGq/ydj1Q4WScHIDsej7loRqZmab2Zgn1YmmjaQ8s50/W3Aumpmz9Zj
	 h939If7pLu+74SVU1woq9fQcar40+2EQfunW0/YJjv2RT15uPEpj796ruHq/1qtLoiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IiIU9t/pme/D3WoLNwnnikBF+jtcauKxTw3ofmYpCiU=;
	b=K2MY4J1/pFPfW0ZCQiIHv/n8xH7ipWPkTAW4WClScmPDy8dT2gNIqt7PPIYeR3N/J61E
	 6clo0lq49t0rM5xuBkWali5Mg+uHpeCKyYXg90j0od694+mI3U/T/8JcjiYAQIpwXCxuN
	 GR0QO4mu0GD9VKWLZHgYR6s7w3mkz8GnBDD7qZAPLC2CTKnRjSAtxTMa1IV0CyHruR7t7
	 LK5Lf0AWlu/M9iIDwC/JqMZNs4fzTeIeNfpsd0suaXIKJcf1BjF2Teeyvzyc9y13maE7H
	 RLxOPKd8wA63DIPyHlHkwKVTaIg4ONg8YvDxiz/wj5/9YdsdGTu8Mfe5NwIFa8oAGbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="RDRD/OcL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81A606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 14:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F81A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RDRD/OcL
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-86156cf8a7eso3575824a34.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794837902; cv=none;
        d=google.com; s=arc-20260327;
        b=jrCIubecpROv5Lt2ETyrmyWTZXOMPvvdMOBKoWJjX6M4lh15O4euR4cVeQlEgWIcjP
         qMMZ991X06yI7z/pqnu2fm0q4ZFn4qAQgJPbhJ5W0eSNNUKEhRl0TAyGgdUh4mcyOCRH
         tqof83ujEWd40q8Bp6c7cYWt1coCPtkGCQXGgFqhEhYg2FtupUYjcGE4oNzDEIeEEqUb
         Mwy5Y5uyMKhD4IogJNWjBuI364IJvTowvksloPD6hlu1PE7IHql6R0mGcFqiBYOgR8Pe
         90ze/77gHxCblx7Kd7okVgTmSTmwZIg3MDGdAJNq6q7nnjO+Eqrjbbf6l9AbXemAUQ8P
         NbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IiIU9t/pme/D3WoLNwnnikBF+jtcauKxTw3ofmYpCiU=;
        fh=LwXPgq+a3FRoTtz1AxeBOeAOLTVsjw5BH2byS1C1X9M=;
        b=VQAxUD4MpTh6e5QfiRQqRwqJeoPtp4ANrg7ig+rClftAbPK3qNJDt3WPeNgh/qovJr
         i5/59h2z7z5nzN1hVpuYCnbO+BH/hyj1lw5Ww9dZVap5Z2Q+hWOLK2vtKmaGuFhMWbnB
         +dNn+vAzBnJ3m7X4uLElSSUU62kpb451qXkHVJwZVaApy9SnbmOOyg7CYnfcEn8MFssl
         1TSrO2qKghK2+ZlQBnHOSg/MsYJRM8ifdBMoAO/1QXgoUbn9JrQdcMZv68s5SX/3ohBt
         XTiunSB9KCGuNahBuBVOxzQuv55OnJa6wfkk77usopC+HXBmr4TtCSlGknA9rTxNZmtX
         WesA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794837902; x=1795442702; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IiIU9t/pme/D3WoLNwnnikBF+jtcauKxTw3ofmYpCiU=;
        b=RDRD/OcLdIq6BBPMomGGzPawAcj++fY9/uI9T/1dA72dsAu8agY8Cu6695ALuLwM0n
         8y09N3w3OnPRYtLA+0e+4U9RcOnky1LhgUOxXzhjjfWtcgZu2/11KvN+/ArJuO0D3/uL
         AyPFayZijP6GzDPeUrJPAizS+wLTSC4SmUVsvfBY1Ile6aaQ9CPg/kv99IdzqKSiLgcp
         KkL/sqlkUbnuggAYKTgRgmfPG3aEwE4AOQ8e2We0/RHTjfPWdEnjmhtf16f6MefhQPs8
         wjXI5xul/QtA/M+DzPqpAjwMvOpyB7m+LDtVfZ6yuRFcXnnU7LE7HpmL5egmcfFarZcf
         uaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794837902; x=1795442702;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IiIU9t/pme/D3WoLNwnnikBF+jtcauKxTw3ofmYpCiU=;
        b=lV9Au128Z+Dl9d7EBwPBrm4JaHU1ReT1dG7/beFOfOHHh5XFPLDcupUOGg5JNUVmhT
         uGr0SzoUHLP8oHuf1JlwGeSD6XhlLAwg9Q/7ok/c3YnoB6Tjbjc0541zVTXCxONi5IlX
         UIDzOmT+6S/KpBSef1qxMxPnnB6Ws7dba0mE7iARrxEcx2tJWWxRd8ebWbJcRpZnUiAw
         WZjjpAYBRFZtt6e07brDY++kEepDXcZOBCaXTDZz6uBhDo9IhuJuY2Y3ZGsWxXjihVGf
         kQ5RtwvMEL26RDYLfg+3JD3+DurBridBcDDan84E8iBtMzi8M8uE+69U448FL+6MFavW
         2H3A==
X-Forwarded-Encrypted: i=1; AL+hErHfXy23nFt4LAPS3iXmxZ3u7h9psBqIyeWeO98ao6CSzDCS2juGqVI+vg7jVtkEP4gSNtA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Asq/hj/FuJkD+U3QU7o9D2IgOGYBpsMPSdS5KO9bEgDSGokQp
	ZiITxIdth5vmX8piR6ss5yqja3N03k/0+ynLacWyuD/JFb/IXPlxZhB/+xCloQewUUlRrii4ppi
	GYRCDMMXoNq5zF9yY2WpLQKwYwcQ2e+XnBIMJx3zdsw==
X-Gm-Gg: AYBFou3VbKCKmE37PQlDGwa33NL/DVAc0Nq0oDzSW8BftT8bnJieupnt85aqnmv5UzL
	Znwt3M2NVOHrrqnvNPwCL5ltXWbWNmiVLMcJXkXqAEN53d05I560CKTCnuwQsn+d5IxtnFYH6iv
	G1vKBqCFQxKvpedC7Wlzd2sAo15lrt2uXT7jse6Clyic0PwP7fG5spTUZguh0ioNIPE+1OnD74u
	uXgerh4LE9N6fqH3YBwg/ObdOo4gsBWpN6tQiKbTFcij7oHkvSU+sHUEBMi/mnI0dWv5Tyf4f0H
	V4wc+70zSIqkWXNDOogIfUJ9ykS6S5wOQ2f22jRfrz2S7y3tvmRgENzh9SuVSeJgHcGsOMoEFk4
	ifIFVhbcMk8thISciyCmdvqt8rAgpRS6r116TeL+3V59QKHFlnUwnm/2bvdQaW072WqyBxsRZnM
	Cm2tH2StW5dv4i/dOwWmvTIVSOGm1ng9c=
X-Received: by 2002:a05:6820:7093:10b0:71a:ea6a:4f51 with SMTP id
 006d021491bc7-71aea6a5809mr1437630eaf.14.1794837902102; Mon, 16 Nov 2026
 06:05:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>
 <20261116084107.6675-1-emmaonana18@gmail.com> <20261116084107.6675-3-emmaonana18@gmail.com>
In-Reply-To: <20261116084107.6675-3-emmaonana18@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 16 Nov 2026 14:04:50 +0000
X-Gm-Features: Aa3M54qRdeOnU1gJ7x3s56OW-hJCPdbvkrK8BlxFfQsIh19-OFAy7vmiVdSA8Lw
Message-ID: <CAG4wq-d_30-B4wQZu48ZQXAORM4QxRqPfmYsmoHS0hiYp1EtTA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] selftests: net: veth: propagate bad-settings
 check failures to exit status
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 09:41:07 +0100 Omokefe Emmanuel Onanaroghene wrote:
> -             echo "fail - set operation successful ?!?" || echo " ok "
> +             { echo "fail - set operation successful ?!?"; ret=1; } || echo " ok "

Two small suggestions:

1. These lines are 85 columns wide, over the 80-column limit.
2. The style is inconsistent with the rest of the file. Other checks
   use if/else instead of a "cmd && { ...; } || ..." chain.

Cheers,
Tianyi
