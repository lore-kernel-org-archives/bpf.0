Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176506;
	b=bVHmGEqOEk1wjss9LN0da0ZRAMS8B1xyng7GC1uE38loScqHt/u6w93Kt9ctRdS4VzyU
	 SgmgrgYWDY0dz+tpjUzIP+AO1IibJY+ShXrQ9lchAWWqrZwUreyoUEFkLRYDQlfnO4aNA
	 4Vl4Usq5Z1AD9xn+RWsIg5X1m9gJyfy7+4Cm4kuGrsUXHVqaxIwvP6g1WvUXfrwYNWsof
	 Yvbu3GNXXfZuJYmANz86zW0oPPs6XDt29PXkXxtsiLMl/H7373BEoiIBfNDVBRg10aI7T
	 aZ3dtOFZUOpBsq3zsx+GfHIiYwIz/yEZcR3xKqRaITMI3GvX1IbScFB/IA263GIoH5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176506;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4od7Sr2E6qFuyNeg8F4/VjgHxNRfB5PEspoSjeOV7ho=;
	b=12cyWW1fexYxAO0Rp3SCDVV7FOu1E+BP7j71yU/N8yen72Deq3p6muik32+y+ZUVgde2
	 4K2zV+mxWkrYDhTgRmK3zzPsozG4igrNMvlTHuDzxzpoOmUG5niEmPuISY1LhKMqenztC
	 IwKIX95jgy+YVQaipXuNDWvooIX7HPlUaPzcXvYk8doNuGTUR9p70TMw3uBZX31VapIkp
	 /CK7abcAfZG+v8hd7ncvhEnay+VtbhgPKWCaajsjttxR+NUmsxbFGk9I3pRuTIooMQCqO
	 3p2C1wfxY8mig02RLRpMJyrR3nD4+jPLhVvQahgoKVz6P5VkLUF3x4+OGyxsYnps6Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=gG5mgoNR;
	arc=none smtp.remote-ip=79.135.106.117
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186A606A31A;
	Wed, 28 Oct 2026 08:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7186A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=gG5mgoNR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793176501; x=1793435701;
	bh=4od7Sr2E6qFuyNeg8F4/VjgHxNRfB5PEspoSjeOV7ho=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gG5mgoNRl4xIkZwhHeUeVMXaTZ1srRIPysbH0wRr/4GQy0pvOMQsDGs/VNecU0kjt
	 MfrSgd/VP3NcM5LjQwuKdM9Yk+aJK1UANTJYBQyOmLqfWlMCoM/SuBmhhNvlon+fan
	 kymLSMcO6TebGb4H/fwI7gCRlJZY36CwSWc/WVCHxfwM+aQUNL46kUm6upIxQipO8V
	 zznEusdjExt+DZBEtA293MxBCQwvHrV3iYu3xE1xUPdGIgJkSMUriKXHnfB2azwxv8
	 n8KZSsmQB4SLMGOAFSZpZ5ifO5Rxk+b/ItwVOgHuBV6A+9MZihjTmXcN5pJnZyYaq4
	 e3zzZiTUVlrGw==
Date: Wed, 28 Oct 2026 08:34:52 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com, maciej.fijalkowski@intel.com, andre.guedes@intel.com, aleksandr.loktionov@intel.com, avigailx.dahan@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3 0/2] igc: fix RX timestamp handling and AF_XDP buffer sizing
Message-ID: <20261028083344.3047350-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 4ded5c9b518f4210a9782b3821add11c04f7d4cf
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

v2..v3
Restore the original timestamp fix and description instead of tracking
frame boundaries. Patch 2 carries Maciej's AF_XDP buffer-size fix unchanged=
.

v1..v2
Changed commit message in attempt to satisfy bots. No code changes.

Maciej's patch:
https://lore.kernel.org/all/at+t%2FjHczGvyXKRN@boxer/

#
# REPRO
#=20
# Receiver: igc / enp1s0 / 10.0.5.175
# Sender:   RTL8125B / enP4p65s0 / 10.0.5.165

# Both hosts
sudo ip link set dev enp1s0 mtu 9000
sudo ip link set dev enP4p65s0 mtu 9000

# Baseline: RX timestamping off
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

# Enable RX timestamping only
sudo hwstamp_ctl -i enp1s0 -t 0 -r 1

# Receiver
sudo timeout 20 tcpdump -ni enp1s0 -s 0 -w /tmp/igc-jumbo.pcap \
  'icmp and host 10.0.5.165'

# Sender
ping -n -M do -c 5 -W 2 -s 8972 10.0.5.175
# 0/5 received

# Receiver
sudo tcpdump -nn -e -vvv -r /tmp/igc-jumbo.pcap
# length 8950
# [total length 9000 > length 8936] (invalid)
# wrong icmp cksum

# Expected Ethernet length: 9014
# Captured length:          8950
# Loss:                       64 =3D 4 continuation buffers * 16 bytes

# Disable RX timestamping again
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

--=20
2.56.GIT

