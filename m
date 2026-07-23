Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51B345EC3;
	Thu, 23 Jul 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794312; cv=none; b=cyQpPmeqZ5h2tR8lNlXsoL0tUdqRdQUFbqLTdFEmGSzwzNSrUjpOuB8HpzFqN5usDJHPVtkOFLiLGJf1sk3dI5WxiVwoRTExVXcEuXcM9WEbYXCncRpxA6ibn0i0+fqM9VXC83yrZVMBpNf6jufOoIFtkEL108w6kIIJPL+I2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794312; c=relaxed/simple;
	bh=ui/UxY8kxVCDBoijpiNYJa/+ntA8IoA2PcHGoiVUQCE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ENyzmKz5vrtKoYxC1SghFph32MIz7muMzqpGz4Atx++UAroiLCW5ro/DEloT3O67HkD773wcQW/gWo8H4Io/18ZHuMRE5Yf7HE+rFgquLWPKHkZKUykOwq/6n+qDuIGPMoBP2etofnzyGbMZR2Z/jBRI+QF2Fu5Q8Vwo3d3/alQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=gVTE0gfR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="gVTE0gfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784794306; x=1785399106; i=t.fuechsel@gmx.de;
	bh=2/EOr/rPal/64wCdGQeVYr+Qy6Q/TJC5WOJOAVteX+w=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gVTE0gfRxXkIHchT3nU7hAmbikDBIzm7uIRBfq/yjLC9nOxCCE4gjA+b1yaCjaDV
	 JdMKAOjYcmkP02Cb54EKor32IQgFMUiP7JZfxwRnUWa1wxDWT5aRSN/peOZW7NzcN
	 /e8vkI7FxJj8MvCpmBDvAX5PR2PvcodvRyWD7/NEN+t3JeEH/COSP+UWdEREavIHf
	 zI+umtmOvef15dvxG2A8j1huPsXO4q0uON1jQE0lWlon1sYL4LefRQeOKpG7L7Sh/
	 iSS0Jyk4uhKY6kDOUu0o3CXWJqTiJu/lSHBOb2uQzUvF9ndI87Lz7PQKbV+GGKRIL
	 MMFjdJkLRlXeLoKfRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1wkeoj455E-00EKet; Thu, 23
 Jul 2026 10:11:46 +0200
Date: Thu, 23 Jul 2026 10:11:43 +0200
From: Tim Fuechsel <t.fuechsel@gmx.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, fmancera@suse.de, ebiggers@kernel.org,
	bpf@vger.kernel.org,
	Lukas Prause <lukas.prause@ikt.uni-hannover.de>,
	Tim Fuechsel <t.fuechsel@gmx.de>
Subject: [PATCHv4 net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <amHMvwtUk6CocMBr@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4MgRcs1sH3t7El6IOYzlfo6DBIpvCXRnCukR4G3JFyo+TChjUkS
 X2GxmHfqkD2Hm+/B5Dd//1cxSgBfP8Ga48HP2g6mUSsaSj5czeqqy4BGJV2MMFZ1sLDIMat
 TBUv18Rsy4u7zfIQZRhu70vlzgUzshVcnYzpNywC0BSXPiEBnqQC6SNOWjUCmBnwd0o5YLQ
 zJqMPYC3yQpIyA1JDod2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C/NPce4Hwc4=;/8SSFbcVLJSsgy+LwrHhHIvkQY7
 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
 JeQ7ioOhPMbCPKsbKigFF

TCP ROCCET is an new congestion control algorithm based on TCP CUBIC
that improves its overall performance in cellular networks. By its mode
of function, CUBIC causes bufferbloat while it tries to detect the
available throughput of a network path. This is particularly a problem
with large buffers in mobile networks. A more detailed description and
analysis of this problem caused by TCP CUBIC can be found in [1].
TCP ROCCET addresses the bufferbloat problem by adding two additional
metrics to detect bufferbloat. The first metric is the relative increase
in RTT from its minimum, the srRTT. Here, bufferbloat can be detected
when RTTs increase due to buffer filling. The second metric is the
acknowledgment arrival rate sampled over 100ms intervals. If CUBIC
increases the send rate or congestion window, and the acknowledgment
arrival rate stays on the same level, the connection is limited by the
bottleneck link's capacity. In such cases, ROCCET reduces the send rate
to prevent bufferbloat. ROCCET uses a modified version of slow start
rather than HyStart because HyStart is known to enter the congestion
avoidance phase too early when used in cellular networks [2]. Therefore,
ROCCET uses a combination of srRTT and the acknowledgment arrival rate to
determine when to exit slow start. For the congestion avoidance phase,
ROCCET relies on the srRTT and monitoring the send and received Bytes
to detect the filling of the bottleneck buffer.

In real-world mobile 5G NR measurements, TCP ROCCET achieves better
performance than CUBIC and BBRv3, by maintaining similar throughput
while reducing the latency. In stationary 5G NR scenarios, the performance
is similar to that of BBRv3. More information about TCP ROCCET and
measurement evaluations can be found here [3].
For the version (2026-07-21) we provide additional performance
evaluation regarding throughput, latency and bandwidth share [4].

[1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
[2] https://doi.org/10.1109/WMNC.2016.7543932
[3] https://doi.org/10.23919/WONS68803.2026.11501781
[4] http://go.lu-h.de/roccet-2026-07-21

Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>

=2D--

Changes since v1:
	* Adjust some comments & Rework commit message
	* Fix Kconfig format
	* Add div-by-0 check variables
	* Fix ack summation from +=3D1 to +=3Dacked (counting now ACKs instead of=
 ACK events)
	* Fix wrapping in time comparisons
	* Remove most module_params, including 'ignore_loss'
	* Remove check that always evaluated to 'true' regarding 'bw_limit_detect=
'

Changes since v2:
	* Improve initialization of roccettcp struct
	* Always react to ECE bits and reset flag
	* Detect plateaus in ACK-rate
	* Fix potential overflow in ACK-rate tracking for high-speed connections
	* Reset ACK-counter correctly on new interval
	* Fix potential integer overflow in rRTT calculation

Changes since v3:
	* Changes in comments & Kconfig help text
	* Adjust commit message, adding reference to new performance evaluation
	* Add minimum RTT probing
	* Use cong_control callback instead of cong_avoid
	* Move CA_EVENT_TX_START event check to dedicated callback (cwnd_event_tx=
_start)
	* Add monitoring of send and receive rate as mentioned in the original pa=
per
	* Refactor of the code
	* Remove kfunc exports
	* Fix potential overflow in rRTT calculation by using 64-bit arithmetic
	* Fix potential division-by-zero in srRTT calculation due to RTT value
	* Initialize ack_rate timestamp to current time
	* Fix potential double penalty when receiving ECN (ECE) mark
	* Reset ack counting when connection goes idle
	* Add module-parameter bounds check on register
=2D--
 net/ipv4/Kconfig      |  12 +
 net/ipv4/Makefile     |   1 +
 net/ipv4/tcp_roccet.c | 974 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 987 insertions(+)
 create mode 100644 net/ipv4/tcp_roccet.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 301b47660305..3545fb0a045b 100644
=2D-- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -663,6 +663,18 @@ config TCP_CONG_CDG
 	    delay gradients." In Networking 2011. Preprint:
 	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-prepri=
nt.pdf
=20
+config TCP_CONG_ROCCET
+	tristate "ROCCET TCP"
+	default n
+	help
+	  TCP ROCCET (RTT oriented CUBIC congestion control exTension) is a
+	  sender-side-only congestion control algorithm based on the TCP CUBIC
+	  protocol stack/TCP CUBIC congestion control algorithm that optimizes
+	  its performance. Especially for networks with large buffers
+	  (wireless, cellular networks), TCP ROCCET has improved performance by
+	  maintaining a similar throughput as CUBIC while reducing latency.
+	  For more information, see: https://arxiv.org/abs/2510.25281
+
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 06e21c26b76f..69e4baaed122 100644
=2D-- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_INET_TCP_DIAG) +=3D tcp_diag.o
 obj-$(CONFIG_INET_UDP_DIAG) +=3D udp_diag.o
 obj-$(CONFIG_INET_RAW_DIAG) +=3D raw_diag.o
 obj-$(CONFIG_TCP_CONG_BBR) +=3D tcp_bbr.o
+obj-$(CONFIG_TCP_CONG_ROCCET) +=3D tcp_roccet.o
 obj-$(CONFIG_TCP_CONG_BIC) +=3D tcp_bic.o
 obj-$(CONFIG_TCP_CONG_CDG) +=3D tcp_cdg.o
 obj-$(CONFIG_TCP_CONG_CUBIC) +=3D tcp_cubic.o
diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
new file mode 100644
index 000000000000..c611e263136b
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,974 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
+ * Extension for 5G and Beyond Networks
+ *
+ * TCP ROCCET is a new TCP congestion control
+ * algorithm suited for current cellular 5G NR beyond networks.
+ * It extends the kernel default congestion control CUBIC
+ * and improves its performance, and additionally solves an
+ * unwanted side effects of CUBIC=E2=80=99s implementation.
+ * ROCCET uses its own Slow Start, called LAUNCH, where loss
+ * is not considered as a congestion event.
+ * The congestion avoidance phase, called ORBITER, uses
+ * CUBIC's window growth function and adds, based on RTT
+ * and ACK rate, congestion events.
+ *
+ * A peer-reviewed paper on TCP ROCCET will be presented
+ * at the WONS 2026 conference.
+ * A draft of the paper is available here:
+ *		https://arxiv.org/abs/2510.25281
+ *
+ *
+ * Further information about CUBIC:
+ * TCP CUBIC: Binary Increase Congestion control for TCP v2.3
+ * Home page:
+ *	http://netsrv.csc.ncsu.edu/twiki/bin/view/Main/BIC
+ * This is from the implementation of CUBIC TCP in
+ * Sangtae Ha, Injong Rhee and Lisong Xu,
+ *  "CUBIC: A New TCP-Friendly High-Speed TCP Variant"
+ *  in ACM SIGOPS Operating System Review, July 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/cubic_a_new_tcp_2008.pdf
+ *
+ * CUBIC integrates a new slow start algorithm, called HyStart.
+ * The details of HyStart are presented in
+ *  Sangtae Ha and Injong Rhee,
+ *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
+ *
+ * All testing results are available from:
+ * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
+ *
+ * Unless CUBIC is enabled and congestion window is large
+ * this behaves the same as the original Reno.
+ */
+
+#include "linux/limits.h"
+#include <linux/math64.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <net/tcp.h>
+
+/* Scale factor beta calculation (max_cwnd =3D snd_cwnd * beta) */
+#define BICTCP_BETA_SCALE 1024
+
+#define BICTCP_HZ 10 /* BIC HZ 2^10 =3D 1024 */
+
+/* Alpha value for the sRrTT  multiplied by 100.
+ * Here 20 represents a value of 0.2
+ */
+#define ROCCET_ALPHA_TIMES_100 20
+
+/* min RTT probe period in seconds */
+#define ROCCET_NEXT_MIN_RTT_PROBE 5000
+
+/* State in which roccet currently operates */
+enum roccet_state {
+	LAUNCH,
+	ORBITER,
+	RTT_PROBE,
+	RTT_PROBE_REFILL,
+	DRAIN
+};
+
+/* TCP ROCCET struct based on the original BICTCP struct with
+ * additions specific to the ROCCET-Algorithm.
+ */
+struct roccettcp {
+	u32 cnt;	/* increase cwnd by 1 after ACKs */
+	u32 last_max_cwnd;	/* last maximum snd_cwnd */
+	u32 last_cwnd;	/* the last snd_cwnd */
+	u32 last_time;	/* time when updated last_cwnd */
+	u32 bic_origin_point;	/* origin point of bic function */
+	u32 bic_K;	/* time to origin point from the
+			 * beginning of the current epoch
+			 */
+	u32 delay_min;	/* min delay (usec) */
+	u32 epoch_start;	/* beginning of an epoch */
+	u32 ack_cnt;	/* number of acks */
+	u32 tcp_cwnd;	/* estimated tcp cwnd */
+	u32 curr_rtt;	/* last sample rtt of current round */
+
+	u32 roccet_last_event_time_us; /* The last time ROCCET was triggered */
+	u32 curr_min_rtt;	/* The current observed minRTT */
+	u32 next_min_rtt_probe;	/* Next time to probe the minRTT */
+	u32 probe_min_rtt_until;	/* End of minRTT probing period */
+	u32 refill_until;	/* End of pipe refill after minRTT probe */
+	u32 cwnd_before_min_rtt_probe;	/* cwnd before min RTT probeing */
+	u32 curr_srrtt;	/* srRTT calculated based on the latest ACK */
+	u32 next_srrtt_check;	/* Next check for srRTT */
+	u32 last_rtt;	/* sample rtt of previous round.
+			 * Used for jitter calculation
+			 */
+
+	u32 interval_snd_seq_start;
+	u32 interval_una_seq_start;
+
+	u32 ack_rate_last_rate_time;	/* Timestamp of the last ACK-rate */
+	u16 ack_rate_last_rate;	/* Last ACK-rate */
+	u16 ack_rate_curr_rate;	/* Current ACK-rate */
+	u16 ack_rate_cnt;	/* Used for counting acks */
+
+	bool ece_received;	/* Set to true if an ECE bit was received */
+	enum roccet_state state; /* State in which roccet currently operates */
+};
+
+/* Parameters that are specific to the ROCCET-Algorithm */
+static uint sr_rtt_upper_bound __read_mostly =3D 100;
+static int ack_rate_diff_ss __read_mostly =3D 10;
+
+module_param(sr_rtt_upper_bound, uint, 0644);
+MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
+module_param(ack_rate_diff_ss, int, 0644);
+MODULE_PARM_DESC(ack_rate_diff_ss,
+		 "ROCCET's threshold to exit slow start if ACK-rate defer by given amou=
nt of segments.");
+
+static int fast_convergence __read_mostly =3D 1;
+static int beta __read_mostly =3D 717; /* =3D 717/1024 (BICTCP_BETA_SCALE=
) */
+static int initial_ssthresh __read_mostly;
+static int bic_scale __read_mostly =3D 41;
+static int tcp_friendliness __read_mostly =3D 1;
+
+static u32 cube_rtt_scale __read_mostly;
+static u32 beta_scale __read_mostly;
+static u64 cube_factor __read_mostly;
+
+/* Note parameters that are used for precomputing scale factors are read-=
only */
+module_param(fast_convergence, int, 0644);
+MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
+module_param(beta, int, 0644);
+MODULE_PARM_DESC(beta, "beta for multiplicative increase");
+module_param(initial_ssthresh, int, 0644);
+MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold=
");
+module_param(bic_scale, int, 0444);
+MODULE_PARM_DESC(bic_scale,
+		 "scale (scaled by 1024) value for bic function (bic_scale/1024)");
+module_param(tcp_friendliness, int, 0644);
+MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
+
+static __always_inline void roccettcp_reset(struct roccettcp *ca)
+{
+	memset(ca, 0, sizeof(struct roccettcp));
+	ca->next_srrtt_check =3D 0;
+	ca->curr_min_rtt =3D ~0U;
+	ca->last_rtt =3D 0;
+	ca->ece_received =3D false;
+
+	ca->roccet_last_event_time_us =3D 0;
+	ca->ack_rate_last_rate =3D 0;
+	/* Initialize to current time to avoid an
+	 * overflow in the ack rate calculation
+	 */
+	ca->ack_rate_last_rate_time =3D jiffies_to_usecs(tcp_jiffies32);
+	ca->ack_rate_curr_rate =3D 0;
+	ca->ack_rate_cnt =3D 0;
+
+	/* Start state is LAUNCH */
+	ca->state =3D LAUNCH;
+}
+
+/* Return true if ROCCET is in min RTT probing.
+ */
+static __always_inline bool is_in_min_rtt_probing(struct roccettcp *ca, u=
32 now)
+{
+	if (ca->probe_min_rtt_until =3D=3D 0)
+		return false;
+	return before(now, ca->probe_min_rtt_until);
+}
+
+static __always_inline void update_min_rtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Check if new lower min RTT was found. If so, set it directly */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
+		/* Probe for the min RTT in ROCCET_NEXT_MIN_RTT_PROBE seconds
+		 * if no other update occurs.
+		 */
+		ca->next_min_rtt_probe =3D
+			jiffies_to_usecs(tcp_jiffies32) +
+			ROCCET_NEXT_MIN_RTT_PROBE * USEC_PER_MSEC;
+	}
+}
+
+/* Return difference between last and current ack rate.
+ */
+static __always_inline s32 get_ack_rate_diff(struct roccettcp *ca)
+{
+	if (ca->ack_rate_curr_rate < ca->ack_rate_last_rate)
+		return 0;
+	return (s32)(ca->ack_rate_curr_rate - ca->ack_rate_last_rate);
+}
+
+/* Update ack rate sampled by 100ms.
+ */
+static __always_inline void update_ack_rate(struct sock *sk, u32 acked, u=
32 now)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	s32 interval =3D USEC_PER_MSEC * 100;
+
+	s32 time_delta =3D (s32)(ca->ack_rate_last_rate_time - now);
+	const s32 idle_threshold =3D USEC_PER_SEC * 2;
+
+	// Check if the time has arrived in the new interval
+	if (time_delta < -interval) {
+		/* Check if the connection was idle for X seconds
+		 * (e.g. no ACK for X seconds)
+		 */
+		if (time_delta < -idle_threshold) {
+			/* Reset ack counting as if a new
+			 * connection was created
+			 */
+			ca->ack_rate_last_rate =3D 0;
+			ca->ack_rate_last_rate_time =3D
+				jiffies_to_usecs(tcp_jiffies32);
+			ca->ack_rate_curr_rate =3D 0;
+			ca->ack_rate_cnt =3D 0;
+		} else {
+			ca->ack_rate_last_rate_time =3D now;
+			ca->ack_rate_last_rate =3D ca->ack_rate_curr_rate;
+			ca->ack_rate_curr_rate =3D ca->ack_rate_cnt;
+			ca->ack_rate_cnt =3D
+				acked; // start counting for the new interval
+		}
+	} else {
+		// Cap the ack count to avoid overflow
+		ca->ack_rate_cnt =3D min_t(u32, ca->ack_rate_cnt + acked,
+					 U16_MAX);
+	}
+}
+
+/* Compute srRTT.
+ */
+static __always_inline void update_srrtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Avoid integer overflow in the calculation below.
+	 * This could occur in cases where we have not yet
+	 * received an RTT sample. In these cases, set the
+	 * rtt to a safe value.
+	 */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_rtt =3D max(ca->curr_rtt, 1);
+		ca->curr_min_rtt =3D ca->curr_rtt;
+	}
+
+	/* Avoid division by zero */
+	if (ca->curr_min_rtt =3D=3D 0) {
+		ca->curr_min_rtt =3D max(ca->curr_min_rtt, 1);
+		return; // skip srRTT update
+	}
+
+	/* Calculate the new rRTT (Scaled by 100).
+	 * 100 * ((sRTT - sRTT_min) / sRTT_min).
+	 *
+	 * curr_min_rtt_timed.rtt is always <=3D than curr_rtt,
+	 * since this is the minimum of the rtt.
+	 *
+	 * 0 is a valid value for rrtt.
+	 */
+	u32 rrtt =3D div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
+			   ca->curr_min_rtt);
+
+	// (1 - alpha) * srRTT + alpha * rRTT
+	ca->curr_srrtt =3D ((100 - ROCCET_ALPHA_TIMES_100) * ca->curr_srrtt +
+			  ROCCET_ALPHA_TIMES_100 * rrtt) /
+			 100;
+}
+
+/* Do a ROCCET congestion event.
+ */
+static __always_inline void roccet_congestion_event(struct sock *sk, u32 =
now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	ca->epoch_start =3D 0;
+	ca->roccet_last_event_time_us =3D now;
+	ca->cnt =3D 100 * tcp_snd_cwnd(tp);
+	/*Set W_max only if the current cwnd is larger */
+	if (tcp_snd_cwnd(tp) > ca->last_max_cwnd)
+		ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
+	tcp_snd_cwnd_set(tp,
+			 min(tp->snd_cwnd_clamp,
+			     max((tcp_snd_cwnd(tp) * beta)
+				 / BICTCP_BETA_SCALE, 2U)));
+	tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
+}
+
+/* Do minimum RTT probing.
+ */
+static __always_inline void roccet_min_rtt_probe(struct sock *sk, u32 now=
)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 interval, probe_cwnd;
+
+	/* Do nothing if we are probing */
+	if (before(now, ca->probe_min_rtt_until) && ca->probe_min_rtt_until > 0)
+		return;
+
+	/* Start of min RTT probing*/
+	if (ca->probe_min_rtt_until =3D=3D 0) {
+		/* Probe 1*RTT or at least 200ms */
+		interval =3D max(200 * USEC_PER_MSEC, ca->curr_rtt);
+
+		/* This is to handle deep shared buffers with loss-based
+		 * congestion control like CUBIC. If the cwnd is not limited
+		 * by the application but falsely detected (see ROCCET paper),
+		 * we have to empty the pipe more.
+		 * If the limit detection is correct this will cause no harm
+		 * to the tcp flow because the cwnd is not fully utilized and
+		 * we set the cwnd to its previous value after probing.
+		 */
+		probe_cwnd =3D max(tcp_snd_cwnd(tp) / 2, TCP_INIT_CWND);
+		if (!tcp_is_cwnd_limited(sk))
+			probe_cwnd =3D max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND);
+
+		ca->probe_min_rtt_until =3D now + interval;
+		ca->cwnd_before_min_rtt_probe =3D tcp_snd_cwnd(tp);
+
+		/* Half the cwnd to drain the buffer for probing.
+		 * Set the ssthresh to the probing cwnd otherwise
+		 * the TCP state machine is in slow start.
+		 */
+		tcp_snd_cwnd_set(tp, probe_cwnd);
+		tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp);
+
+		/* Reset current min RTT to allow probing for
+		 * a new lower and higher minimum RTT.
+		 */
+		ca->curr_min_rtt =3D ~0U;
+
+		/* Refill the pipe after probing.
+		 * To this end we need the previous cwnd over
+		 * the probing interval.
+		 */
+		ca->refill_until =3D ca->probe_min_rtt_until + interval;
+	} else if (before(now, ca->refill_until)) {
+		/* Reset cwnd and refill the pipe. */
+		if (ca->state !=3D RTT_PROBE_REFILL) {
+			tcp_snd_cwnd_set(tp, ca->cwnd_before_min_rtt_probe);
+			tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp);
+			ca->state =3D RTT_PROBE_REFILL;
+		}
+	} else {
+		/* End min RTT probing phase. */
+		ca->probe_min_rtt_until =3D 0;
+		ca->state =3D ORBITER;
+	}
+}
+
+static void roccettcp_init(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	roccettcp_reset(ca);
+
+	if (initial_ssthresh)
+		tcp_sk(sk)->snd_ssthresh =3D initial_ssthresh;
+
+	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
+	//WRITE_ONCE(sk->sk_pacing_rate, 0);
+}
+
+static void roccettcp_cwnd_event_tx_start(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D tcp_jiffies32;
+	s32 delta;
+
+	delta =3D now - tcp_sk(sk)->lsndtime;
+
+	/* We were application limited (idle) for a while.
+	 * Shift epoch_start to keep cwnd growth to cubic curve.
+	 */
+	if (ca->epoch_start && delta > 0) {
+		ca->epoch_start +=3D delta;
+		if (after(ca->epoch_start, now))
+			ca->epoch_start =3D now;
+	}
+}
+
+/* calculate the cubic root of x using a table lookup followed by one
+ * Newton-Raphson iteration.
+ * Avg err ~=3D 0.195%
+ */
+static u32 cubic_root(u64 a)
+{
+	u32 x, b, shift;
+	/* cbrt(x) MSB values for x MSB values in [0..63].
+	 * Precomputed then refined by hand - Willy Tarreau
+	 *
+	 * For x in [0..63],
+	 *   v =3D cbrt(x << 18) - 1
+	 *   cbrt(x) =3D (v[x] + 10) >> 6
+	 */
+	static const u8 v[] =3D {
+		/* 0x00 */ 0,	54,  54,  54,  118, 118, 118, 118,
+		/* 0x08 */ 123, 129, 134, 138, 143, 147, 151, 156,
+		/* 0x10 */ 157, 161, 164, 168, 170, 173, 176, 179,
+		/* 0x18 */ 181, 185, 187, 190, 192, 194, 197, 199,
+		/* 0x20 */ 200, 202, 204, 206, 209, 211, 213, 215,
+		/* 0x28 */ 217, 219, 221, 222, 224, 225, 227, 229,
+		/* 0x30 */ 231, 232, 234, 236, 237, 239, 240, 242,
+		/* 0x38 */ 244, 245, 246, 248, 250, 251, 252, 254,
+	};
+
+	b =3D fls64(a);
+	if (b < 7) {
+		/* a in [0..63] */
+		return ((u32)v[(u32)a] + 35) >> 6;
+	}
+
+	b =3D ((b * 84) >> 8) - 1;
+	shift =3D (a >> (b * 3));
+
+	x =3D ((u32)(((u32)v[shift] + 10) << b)) >> 6;
+
+	/* Newton-Raphson iteration
+	 *                         2
+	 * x    =3D ( 2 * x  +  a / x  ) / 3
+	 *  k+1          k         k
+	 */
+	x =3D (2 * x + (u32)div64_u64(a, (u64)x * (u64)(x - 1)));
+	x =3D ((x * 341) >> 10);
+	return x;
+}
+
+/* Compute congestion window to use.
+ */
+static __always_inline void bictcp_update(struct roccettcp *ca, u32 cwnd,
+					  u32 acked)
+{
+	u32 delta, bic_target, max_cnt;
+	u64 offs, t;
+
+	ca->ack_cnt +=3D acked; /* count the number of ACKed packets */
+
+	if (ca->last_cwnd =3D=3D cwnd &&
+	    (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
+		return;
+
+	/* The CUBIC function can update ca->cnt at most once per jiffy.
+	 * On all cwnd reduction events, ca->epoch_start is set to 0,
+	 * which will force a recalculation of ca->cnt.
+	 */
+	if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
+		goto tcp_friendliness;
+
+	ca->last_cwnd =3D cwnd;
+	ca->last_time =3D tcp_jiffies32;
+
+	if (ca->epoch_start =3D=3D 0) {
+		ca->epoch_start =3D tcp_jiffies32; /* record beginning */
+		ca->ack_cnt =3D acked; /* start counting */
+		ca->tcp_cwnd =3D cwnd; /* syn with cubic */
+
+		if (ca->last_max_cwnd <=3D cwnd) {
+			ca->bic_K =3D 0;
+			ca->bic_origin_point =3D cwnd;
+		} else {
+			/* Compute new K based on
+			 * (wmax-cwnd) * (srtt>>3 / HZ) / c * 2^(3*bictcp_HZ)
+			 */
+			ca->bic_K =3D cubic_root(cube_factor *
+					       (ca->last_max_cwnd - cwnd));
+			ca->bic_origin_point =3D ca->last_max_cwnd;
+		}
+	}
+
+	/* cubic function - calc */
+	/* calculate c * time^3 / rtt,
+	 *  while considering overflow in calculation of time^3
+	 * (so time^3 is done by using 64 bit)
+	 * and without the support of division of 64bit numbers
+	 * (so all divisions are done by using 32 bit)
+	 *  also NOTE the unit of those variables
+	 *	  time  =3D (t - K) / 2^bictcp_HZ
+	 *	  c =3D bic_scale >> 10
+	 * rtt  =3D (srtt >> 3) / HZ
+	 * !!! The following code does not have overflow problems,
+	 * if the cwnd < 1 million packets !!!
+	 */
+
+	t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
+	t +=3D usecs_to_jiffies(ca->delay_min);
+
+	/* change the unit from HZ to bictcp_HZ */
+	t <<=3D BICTCP_HZ;
+	do_div(t, HZ);
+
+	if (t < ca->bic_K) /* t - K */
+		offs =3D ca->bic_K - t;
+	else
+		offs =3D t - ca->bic_K;
+
+	/* c/rtt * (t-K)^3 */
+	delta =3D (cube_rtt_scale * offs * offs * offs) >> (10 + 3 * BICTCP_HZ);
+	if (t < ca->bic_K) /* below origin*/
+		bic_target =3D ca->bic_origin_point - delta;
+	else /* above origin*/
+		bic_target =3D ca->bic_origin_point + delta;
+
+	/* cubic function - calc bictcp_cnt*/
+	if (bic_target > cwnd)
+		ca->cnt =3D cwnd / (bic_target - cwnd);
+	else
+		ca->cnt =3D 100 * cwnd; /* very small increment*/
+
+	/* The initial growth of cubic function may be too conservative
+	 * when the available bandwidth is still unknown.
+	 */
+	if (ca->last_max_cwnd =3D=3D 0 && ca->cnt > 20)
+		ca->cnt =3D 20; /* increase cwnd 5% per RTT */
+
+tcp_friendliness:
+	/* TCP Friendly */
+	if (tcp_friendliness) {
+		u32 scale =3D beta_scale;
+
+		delta =3D (cwnd * scale) >> 3;
+		while (ca->ack_cnt > delta) { /* update tcp cwnd */
+			ca->ack_cnt -=3D delta;
+			ca->tcp_cwnd++;
+		}
+
+		if (ca->tcp_cwnd > cwnd) { /* if bic is slower than tcp */
+			delta =3D ca->tcp_cwnd - cwnd;
+			max_cnt =3D cwnd / delta;
+			if (ca->cnt > max_cnt)
+				ca->cnt =3D max_cnt;
+		}
+	}
+
+	/* The maximum rate of cwnd increase CUBIC allows is 1 packet per
+	 * 2 packets ACKed, meaning cwnd grows at 1.5x per RTT.
+	 */
+	ca->cnt =3D max(ca->cnt, 2U);
+}
+
+static void roccettcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	bool evaluate_srrtt =3D false;
+	bool send_more_than_acked =3D false;
+	u32 roccet_xj;
+	u32 jitter;
+	u32 send, received;
+
+	if (ca->state =3D=3D LAUNCH) {
+		/* LAUNCH: Detect an exit point for tcp slow start
+		 * in networks with large buffers of multiple BDP
+		 * Like in cellular networks (5G, ...).
+		 * Or exit LAUNCH if cwnd is too large for application layer
+		 * data rate (tcp cwnd validation).
+		 */
+		if ((ca->curr_srrtt > sr_rtt_upper_bound &&
+		     get_ack_rate_diff(ca) <=3D ack_rate_diff_ss) ||
+		    !tcp_is_cwnd_limited(sk)) {
+			ca->epoch_start =3D 0;
+
+			/* Handle initial slow start.
+			 * Most bufferbloat occurs here
+			 */
+			if (tp->snd_ssthresh =3D=3D TCP_INFINITE_SSTHRESH) {
+				tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp)
+								/ 2;
+				/* since this is the initial slow start,
+				 * the min cwnd won't be 1, so the window
+				 * can't be set to 0 by accident.
+				 * Halfing the cwnd will undo the previous step
+				 * of slow start. Which is fine since the pipe
+				 * is already full.
+				 */
+				tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2,
+							 TCP_INIT_CWND));
+			} else {
+				tcp_sk(sk)->snd_ssthresh =3D
+					tcp_snd_cwnd(tp) -
+					(tcp_snd_cwnd(tp) / 3);
+				tcp_snd_cwnd_set(tp, tcp_snd_cwnd(tp) -
+						 (tcp_snd_cwnd(tp) / 3));
+			}
+			ca->roccet_last_event_time_us =3D now;
+			return;
+		}
+
+		acked =3D tcp_slow_start(tp, acked);
+		if (!acked)
+			return;
+
+	} else if (ca->state =3D=3D ORBITER) {
+		/* ORBITER: Increase the cwnd by using the CUBIC
+		 * cwnd growth function, if no roccet congestion
+		 * event is detechted.
+		 */
+
+		/* Calculate jitter */
+		if ((s32)(ca->curr_rtt - ca->last_rtt) < 0)
+			jitter =3D ca->last_rtt - ca->curr_rtt;
+		else
+			jitter =3D ca->curr_rtt - ca->last_rtt;
+
+		if (ca->next_srrtt_check =3D=3D 0)
+			ca->next_srrtt_check =3D now + 5 * ca->curr_rtt;
+
+		/* Calculate if more bytes was send than received
+		 * in the time interval.
+		 */
+		if (before(tp->snd_nxt, ca->interval_snd_seq_start)) {
+			/* We had a wrap around in seq no counter */
+			send =3D (~0U - ca->interval_snd_seq_start + tp->snd_nxt);
+		} else {
+			send =3D (tp->snd_nxt - ca->interval_snd_seq_start);
+		}
+		if (before(tp->snd_una, ca->interval_una_seq_start)) {
+			/* We had a wrap around in seq no counter */
+			received =3D (~0U - ca->interval_una_seq_start +
+				    tp->snd_una);
+		} else {
+			received =3D (tp->snd_una - ca->interval_una_seq_start);
+		}
+
+		/* Here we use a guard space of 1% of the current cwnd.
+		 * We do this to avoid a false positive evaluation due
+		 * to delays caused by jitter or scheduling.
+		 */
+		send_more_than_acked =3D
+			send >
+			received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100);
+
+		/* Check if it's time to evaluate the srRTT */
+		if ((s32)(ca->next_srrtt_check - now) < 0) {
+			evaluate_srrtt =3D true;
+
+			/* reset struct and set next end of period */
+			ca->next_srrtt_check =3D now + 5 * ca->curr_rtt;
+
+			/* Reset Rate calculation */
+			ca->interval_snd_seq_start =3D tp->snd_nxt;
+			ca->interval_una_seq_start =3D tp->snd_una;
+		}
+
+		/* Respects the jitter of the connection and add it on top of
+		 * the upper bound for the srRTT.
+		 */
+		roccet_xj =3D div_u64((u64)jitter * 100, ca->curr_min_rtt) +
+			    sr_rtt_upper_bound;
+		if (roccet_xj < sr_rtt_upper_bound)
+			roccet_xj =3D sr_rtt_upper_bound;
+
+		/* The srRTT exceeds the upper bound if bufferbloat happens.
+		 * Here, we want to reduce the cwnd and drain the buffer.
+		 */
+		if (ca->curr_srrtt > roccet_xj && evaluate_srrtt &&
+		    send_more_than_acked) {
+			roccet_congestion_event(sk, now);
+			return;
+		}
+
+		/* Terminates this function if cwnd is not fully utilized.
+		 * In mobile networks like 5G, this termination causes the
+		 * cwnd to be frozen at an excessively high value. This is
+		 * because slow start or HyStart massively exceed the available
+		 * bandwidth and leave the cwnd at an excessively high value.
+		 * The cwnd cannot therefore be fully utilized because it is
+		 * limited by the connection capacity.
+		 */
+		if (!tcp_is_cwnd_limited(sk) || send_more_than_acked)
+			return;
+
+		bictcp_update(ca, tcp_snd_cwnd(tp), acked);
+		tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
+	}
+}
+
+static u32 roccettcp_recalc_ssthresh(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 cwnd =3D tcp_snd_cwnd(tp);
+
+	/* If a loss/ECN occurs in the refill phase of min RTT probing
+	 * we reduce the cwnd and abort the refill.
+	 */
+	if (ca->state =3D=3D RTT_PROBE_REFILL)
+		ca->state =3D ORBITER;
+
+	/* If ROCCET is in min RTT probing and a loss/ECN occurs,
+	 * we use the cwnd before the probing interval to
+	 * calculate the cwnd reduction and continue probing.
+	 * After min RTT probing the cwnd is set to the reduced
+	 * value. During min RTT probing it is very likely that
+	 * congestion was caused by the cwnd value before min
+	 * RTT probing.
+	 */
+	if (ca->state =3D=3D RTT_PROBE) {
+		/* Handle ECN as cubic congestion event in min
+		 * RTT probe.
+		 */
+		ca->ece_received =3D false;
+
+		ca->epoch_start =3D 0; /* end of epoch */
+
+		/* Wmax and fast convergence */
+		if (cwnd < ca->last_max_cwnd && fast_convergence)
+			ca->last_max_cwnd =3D
+				(cwnd * (BICTCP_BETA_SCALE + beta)) /
+				(2 * BICTCP_BETA_SCALE);
+		else
+			ca->last_max_cwnd =3D cwnd;
+
+		cwnd =3D ca->cwnd_before_min_rtt_probe;
+		ca->cwnd_before_min_rtt_probe =3D
+			max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+
+		return cwnd;
+	}
+
+	/* Handle ECN as ROCCET congestion event. */
+	if (ca->ece_received) {
+		ca->ece_received =3D false;
+		roccet_congestion_event(sk, jiffies_to_usecs(tcp_jiffies32));
+		return tcp_snd_cwnd(tp);
+	}
+
+	/* On loss in slow start enter congestion avoidance
+	 * without a cwnd reduction. Additional slow start
+	 * exit conditions with a cwnd reduction are handled
+	 * in roccettcp_cong_avoid.
+	 */
+	if (tcp_in_slow_start(tp))
+		return tcp_snd_cwnd(tp);
+
+	/* CUBIC congestion event */
+	ca->epoch_start =3D 0; /* end of epoch */
+
+	/* Wmax and fast convergence */
+	if (tcp_snd_cwnd(tp) < ca->last_max_cwnd && fast_convergence)
+		ca->last_max_cwnd =3D
+			(tcp_snd_cwnd(tp) * (BICTCP_BETA_SCALE + beta)) /
+			(2 * BICTCP_BETA_SCALE);
+	else
+		ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
+
+	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+static void roccettcp_state(struct sock *sk, u8 new_state)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	if (new_state =3D=3D TCP_CA_Loss) {
+		roccettcp_reset(ca);
+	} else if (new_state =3D=3D TCP_CA_Recovery) {
+		tcp_sk(sk)->snd_ssthresh =3D roccettcp_recalc_ssthresh(sk);
+		tcp_snd_cwnd_set(tp, tcp_sk(sk)->snd_ssthresh);
+	}
+}
+
+static void roccettcp_acked(struct sock *sk, const struct ack_sample *sam=
ple)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Some calls are for duplicates without timestamps */
+	if (sample->rtt_us < 0)
+		return;
+
+	/* Discard delay samples right after fast recovery */
+	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
+		return;
+
+	u32 delay =3D sample->rtt_us;
+
+	if (delay =3D=3D 0)
+		delay =3D 1;
+
+	/* first time call or link delay decreases */
+	if (ca->delay_min =3D=3D 0 || (s32)(delay - ca->delay_min) < 0)
+		ca->delay_min =3D delay;
+
+	/* Get valid sample for roccet */
+	if (sample->rtt_us > 0) {
+		ca->last_rtt =3D ca->curr_rtt;
+		ca->curr_rtt =3D sample->rtt_us;
+	}
+}
+
+static void roccet_in_ack_event(struct sock *sk, u32 flags)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Handle ECE bit.
+	 * Processing of ECE events is done in roccettcp_recalc_ssthresh()
+	 */
+	if (flags & CA_ACK_ECE)
+		ca->ece_received =3D true;
+}
+
+static void roccet_control(struct sock *sk, u32 ack, int flag,
+			   const struct rate_sample *rs)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	u64 rate;
+
+	/* Update roccet parameters */
+	update_ack_rate(sk, rs->acked_sacked, now);
+	update_min_rtt(sk);
+	update_srrtt(sk);
+
+	/* Set values for send and receive rate */
+	if (ca->interval_snd_seq_start =3D=3D 0) {
+		ca->interval_snd_seq_start =3D tp->snd_nxt;
+		ca->interval_una_seq_start =3D tp->snd_una;
+	}
+
+	/* Update roccet state */
+	if (tcp_in_slow_start(tp)) {
+		ca->state =3D LAUNCH;
+	} else if ((s32)now - ca->roccet_last_event_time_us <=3D
+		   100 * USEC_PER_MSEC) {
+		ca->state =3D DRAIN;
+	} else if (after(now, ca->next_min_rtt_probe) ||
+		   ca->state =3D=3D RTT_PROBE || ca->state =3D=3D RTT_PROBE_REFILL) {
+		if (ca->state !=3D RTT_PROBE_REFILL)
+			ca->state =3D RTT_PROBE;
+		roccet_min_rtt_probe(sk, now);
+	} else {
+		ca->state =3D ORBITER;
+	}
+
+	/* If nothing was fully acked do not increase the cwnd */
+	if (!rs->acked_sacked)
+		return;
+
+	/* Increase the cwnd.
+	 * Loss recovery is handled in roccettcp_state()
+	 */
+	roccettcp_cong_avoid(sk, ack, rs->acked_sacked);
+
+	/* Adjust pacing rate. The code here is similar to the
+	 * pacing rate adjustments in tcp_input.c tcp_cong_control().
+	 * In LAUNCH (slow start) we want a pacing of 200% and
+	 * in ORBITER (congestion avoidance) we adjust the pacing
+	 * to 100% and do not use the sysctl_tcp_pacing_ca_ratio.
+	 */
+
+	/* set sk_pacing_rate to 200 % of current rate (mss * cwnd / srtt) */
+	rate =3D (u64)tp->mss_cache * ((USEC_PER_SEC / 100) << 3);
+
+	/* current rate is (cwnd * mss) / srtt
+	 * In Slow Start [1], set sk_pacing_rate to 200 % the current rate.
+	 * In Congestion Avoidance phase, set it to 120 % the current rate.
+	 *
+	 * [1]: Normal Slow Start cond is (tp->snd_cwnd < tp->snd_ssthresh)
+	 *	 If snd_cwnd >=3D (tp->snd_ssthresh / 2), we are approaching
+	 *	 end of slow start and should slow down.
+	 */
+	if (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2)
+		rate *=3D READ_ONCE
+			(sock_net(sk)->ipv4.sysctl_tcp_pacing_ss_ratio);
+	else
+		/* Pacing rate of 100%
+		 * (instead of ipv4.sysctl_tcp_pacing_ca_ratio)
+		 */
+		rate *=3D 100;
+
+	rate *=3D max(tcp_snd_cwnd(tp), tp->packets_out);
+
+	if (likely(tp->srtt_us))
+		do_div(rate, tp->srtt_us);
+
+	/* WRITE_ONCE() is needed because sch_fq fetches sk_pacing_rate
+	 * without any lock. We want to make sure compiler won't store
+	 * intermediate values in this location.
+	 */
+	WRITE_ONCE(sk->sk_pacing_rate,
+		   min_t(u64, rate, READ_ONCE(sk->sk_max_pacing_rate)));
+}
+
+static struct tcp_congestion_ops roccet_tcp __read_mostly =3D {
+	.init =3D roccettcp_init,
+	.ssthresh =3D roccettcp_recalc_ssthresh,
+	.set_state =3D roccettcp_state,
+	.undo_cwnd =3D tcp_reno_undo_cwnd,
+	.cwnd_event_tx_start =3D roccettcp_cwnd_event_tx_start,
+	.pkts_acked =3D roccettcp_acked,
+	.in_ack_event =3D roccet_in_ack_event,
+	.cong_control =3D roccet_control,
+	.owner =3D THIS_MODULE,
+	.name =3D "roccet",
+};
+
+static int __init roccettcp_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
+
+	/*
+	 * Validate parameters to avoid division by zero errors.
+	 */
+	if (beta <=3D 0 || beta >=3D BICTCP_BETA_SCALE) {
+		pr_err("roccet: beta must be between 0 and %d\n",
+		       BICTCP_BETA_SCALE);
+		return -EINVAL;
+	}
+
+	if (bic_scale <=3D 0) {
+		pr_err("roccet: bic_scale must be positive\n");
+		return -EINVAL;
+	}
+
+	/* Precompute a bunch of the scaling factors that are used per-packet
+	 * based on SRTT of 100ms
+	 */
+	beta_scale =3D
+		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
+
+	cube_rtt_scale =3D (bic_scale * 10); /* 1024*c/rtt */
+
+	/* calculate the "K" for (wmax-cwnd) =3D c/rtt * K^3
+	 *  so K =3D cubic_root( (wmax-cwnd)*rtt/c )
+	 * the unit of K is bictcp_HZ=3D2^10, not HZ
+	 *
+	 *  c =3D bic_scale >> 10
+	 *  rtt =3D 100ms
+	 *
+	 * the following code has been designed and tested for
+	 * cwnd < 1 million packets
+	 * RTT < 100 seconds
+	 * HZ < 1,000,00  (corresponding to 10 nano-second)
+	 */
+
+	/* 1/c * 2^2*bictcp_HZ * srtt */
+	cube_factor =3D 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
+
+	/* divide by bic_scale and by constant Srtt (100ms) */
+	do_div(cube_factor, bic_scale * 10);
+
+	return tcp_register_congestion_control(&roccet_tcp);
+}
+
+static void __exit roccettcp_unregister(void)
+{
+	tcp_unregister_congestion_control(&roccet_tcp);
+}
+
+module_init(roccettcp_register);
+module_exit(roccettcp_unregister);
+
+MODULE_AUTHOR("Lukas Prause, Tim F=C3=BCchsel");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ROCCET TCP");

base-commit: 1df10cef2d1e7f9f2fb7eddb67fc70d3abf101f9
=2D-=20
2.43.0

