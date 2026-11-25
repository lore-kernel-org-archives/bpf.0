Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606305;
	b=xBo6MjzhjTOSNOHfDDIWKvNjiZNN+i2KrmlYiIv4AdWHQzNQ67zGf8qziB+Q4DPDGjnu
	 KJgQykhfQ1mXdiUz8T3p1wuyiqTCfQ2+j+mcOzxtWlEQHxiNARWY2vqofJnJxJdQL05Jk
	 EhutUeGg18uoPxydVGH1WW1Wnr/m1eBkAuHT8+9F4nZ3fRzscqA/g6taDjsZ5c216XBFC
	 rLPO4yLBMU2W+XrxUgQicWYGvX43nyctkQI/dYiI4RjJrwV2kWgy2GE+Adt903bhMTFlt
	 zjp0jQXZIU1/44xadQ5ijkVFjsZT9yGtN3RIleJ/WdNFIjK5H3qchfW7X/o0loQEKRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606305;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HGTi6niermcp+bXbJA8bBsO4tSFHNGHuZ8YGOPIWv88=;
	b=gjMHlLv84j+nmTYt+sqczdU00Gb+Qx+CBnd35GIwmYIBM7MXVJck32jleIWHZ0nK2anq
	 rUUV2MfxT7Ctj1w5okYBnk9wi/MsXJw5EkRKNIkyLT7YKXxg3uORJFXZik9szEDgEU9ZN
	 as5t6mFYO43eV1coehNcd4a5qCH8I3nYkXwG0dOC1UEMqqJhOng6Lvn0nkWr8Mp3wJ/bI
	 cnM+8LmdOe3UhydNqdHjE/dbPurSlNb/tHP/b9g9UmQeUZWD6PIX2VAQuRkRD8KkMlNPe
	 vbGWyrGxHeQD9Ukybe6nmUsV/e9+oWAoOyoJOf0bQmqJp0X3O0oW7br4lbEXY6vymnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDiPHOVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B40606A33B;
	Wed, 25 Nov 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDiPHOVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E104C1F000D4;
	Wed, 25 Nov 2026 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795606304;
	bh=HGTi6niermcp+bXbJA8bBsO4tSFHNGHuZ8YGOPIWv88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GDiPHOVlObEOZ7r2PSIjiU6Hcm8DmjWgqpK5mRnX8IDpQ3k9e3AKboCyCQQucCAe5
	 ZOhKsJnjJV9o2cEfLXPJ7ZjXcmb72f/7N5d6bHMix3+Qsk0pcqo165m1ro6l/lu8oa
	 0OFRJJwu6tM+doiGOcl+j1tPOO81cB3ZVGk59fNyOhPbmP2jEzhZm2uXlgsO4RZYwO
	 WRWh4qBSW1TcJzzJnyjZ/G+kXBsNVooRJeuCjlBHGpKKkDwbqpp94+40U1XH4XYj8H
	 mTiwNys4YnFLB78uMm0Vth4tl95LDFvKO7Z1PoOXSYNb2+VKqt0tXNjx4DoF6LfqBD
	 MHfz6qG0MY/Jw==
Message-ID: <10125984-a1a8-45ca-9a83-e71c2be2114e@kernel.org>
Date: Wed, 25 Nov 2026 12:31:37 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 4/9] net: state the "XDP excludes HW-GRO" rule
 in the core
Content-Language: fr
To: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 manishc@marvell.com, joshwash@google.com, hramamurthy@google.com,
 tariqt@nvidia.com, saeedm@nvidia.com, daniel@iogearbox.net, hawk@kernel.org,
 sdf@fomichev.me, willemb@google.com, przemyslaw.kitszel@intel.com,
 bpf@vger.kernel.org
References: <20261122010112.1471146-1-kuba@kernel.org>
 <20261122010112.1471146-5-kuba@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261122010112.1471146-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub, Paolo,

Thank you for this series!

On 22/11/2026 02:01, Jakub Kicinski wrote:
> Clear HW-GRO in __netdev_update_features(), and make sure XDP setup
> paths refresh the features.

If I'm not mistaken, since this series, the HW tests are marked as
failed because ring-reconfig-py fails on both virtio_net (virt-drv-hw
and virt-drv-hw-dbg): with the RX ring at 1, no traffic gets through.

  https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw/results/925126/14-ring-reconfig-py/stdout

From what I understood, ping.py runs xdpgeneric earlier in the same VM.
dev_disable_gro_hw() used to leave HW-GRO off for good, so
ring_reconfig.py never ran with it on. Now HW-GRO is restored and big
GSO frames no longer fit into the 1-entry ring. So I guess the real
issue is in virtio_net (or the test), not in this patch. This patch just
made it visible.

(Also, maybe related: xsk-reconfig-py now skips on CX7 (zerocopy bind
fails) since the same branch).

Because these issues are on HW tests, and this patch seems to reveal
existing issues, I'm not going to mark it as 'changes-requested', but
ignore them on NIPA for the moment.

@Paolo: can you ping me if you decide to drop the series, please? :)

Cheers,
Matt

